FROM node:lts-bookworm AS korean-patcher

WORKDIR /opt/build-stage
RUN git clone --recurse-submodules -j8 https://github.com/NavyStack/planka.git

FROM node:lts-bookworm as server-dependencies

WORKDIR /app

COPY --from=korean-patcher /opt/build-stage/planka/server/package.json /opt/build-stage/planka/server/package-lock.json /app/

RUN npm install npm@latest --global \
  && npm install pnpm --global \
  && pnpm import \
  && pnpm install --prod

FROM node:lts-bookworm AS client

WORKDIR /app

COPY --from=korean-patcher /opt/build-stage/planka/client/package.json /opt/build-stage/planka/client/package-lock.json /app/

RUN npm install npm@latest --global \
  && npm install pnpm --global \
  && pnpm import \
  && pnpm install --prod

COPY --from=korean-patcher /opt/build-stage/planka/client /app/

RUN DISABLE_ESLINT_PLUGIN=true npm run build

RUN wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem -P /app/build/
RUN chmod 600 /app/build/DigiCertGlobalRootCA.crt.pem

FROM node:lts-bookworm-slim AS FINAL

USER node
WORKDIR /app

COPY --from=korean-patcher --chown=node:node /opt/build-stage/planka/start.sh /app/
COPY --from=korean-patcher --chown=node:node /opt/build-stage/planka/server /app/

RUN mv .env.sample .env

COPY --from=server-dependencies --chown=node:node /app/node_modules node_modules

COPY --from=client --chown=node:node /app/build public
COPY --from=client --chown=node:node /app/build/index.html views/index.ejs

VOLUME /app/public/user-avatars
VOLUME /app/public/project-background-images
VOLUME /app/private/attachments

EXPOSE 1337

CMD ["./start.sh"]
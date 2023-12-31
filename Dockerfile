FROM node:lts-bookworm AS bedrock
WORKDIR /opt/build-stage
RUN git clone --recurse-submodules -j8 https://github.com/plankanban/planka.git
RUN apt update \
    && apt -y install tini \
    && cp /usr/bin/tini /usr/local/bin/tini

FROM node:lts-bookworm as server
WORKDIR /app
COPY --from=bedrock /opt/build-stage/planka/server/package.json /opt/build-stage/planka/server/package-lock.json /app/
RUN npm install npm@latest --global \
  && npm install pnpm --global \
  && pnpm import \
  && pnpm install --prod

FROM node:lts-bookworm AS client
WORKDIR /app
COPY --from=bedrock /opt/build-stage/planka/client/package.json /opt/build-stage/planka/client/package-lock.json /app/
RUN npm install npm@latest --global \
  && npm install pnpm --global \
  && pnpm import \
  && pnpm install --prod
COPY --from=bedrock /opt/build-stage/planka/client /app/
RUN DISABLE_ESLINT_PLUGIN=true npm run build
RUN wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem -P /app/build/
RUN chmod 600 /app/build/DigiCertGlobalRootCA.crt.pem

FROM node:lts-bookworm-slim AS layer-cutter
ARG user=planka
RUN useradd --create-home --shell /bin/bash $user
USER $user
WORKDIR /app
COPY --from=bedrock --chown=$user:$user /opt/build-stage/planka/start.sh /app/
COPY --from=bedrock --chown=$user:$user /opt/build-stage/planka/server /app/
COPY --from=bedrock --chown=$user:$user /usr/local/bin/tini /usr/local/bin/tini
COPY docker-entrypoint.sh /usr/local/bin/
RUN mv .env.sample .env
COPY --from=server --chown=$user:$user /app/node_modules node_modules
COPY --from=client --chown=$user:$user /app/build public
COPY --from=client --chown=$user:$user /app/build/index.html views/index.ejs

FROM node:lts-bookworm-slim AS FINAL
ARG user=planka
RUN useradd --create-home --shell /bin/bash $user
USER $user
WORKDIR /app
COPY --from=layer-cutter --chown=$user:$user /app/ /app/
COPY --from=layer-cutter /usr/local/bin/docker-entrypoint.sh /usr/local/bin/tini /usr/local/bin/
VOLUME /app/public/user-avatars
VOLUME /app/public/project-background-images
VOLUME /app/private/attachments
EXPOSE 1337/tcp
ENTRYPOINT ["tini", "--"]
CMD ["docker-entrypoint.sh"]
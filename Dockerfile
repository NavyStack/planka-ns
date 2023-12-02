FROM amazonlinux:2023.2.20231113.0 AS final
ARG PLANKA_VERSION=v1.15.0

RUN dnf -y install \
    nodejs unzip && \
    mkdir -p /var/www/planka/ && \
    cd /var/www/planka && \
    curl -fsSL https://github.com/plankanban/planka/releases/download/${PLANKA_VERSION}/planka-prebuild-${PLANKA_VERSION}.zip -o planka-prebuild.zip && \
    unzip planka-prebuild.zip -d /var/www/ && \
    rm planka-prebuild.zip && \
    npm install && \
    mv .env.sample .env && \
    dnf -y remove \
        unzip \
    && \
        dnf clean all && \
        dnf autoremove

VOLUME /var/www/planka/public/user-avatars
VOLUME /var/www/planka/public/project-background-images
VOLUME /var/www/planka/private/attachments
WORKDIR /var/www/planka/

EXPOSE 1337

CMD ["./start.sh"]
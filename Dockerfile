FROM armhf/rpi-node
MAINTAINER Robert Doering <rdoering.info@gmail.com>

RUN apk --update add nodejs gifsicle optipng avahi-dev
RUN npm install -g bower grunt-cli

WORKDIR /dashkiosk
COPY ./dashkiosk /dashkiosk/
ENV NPM_CONFIG_LOGLEVEL warn
RUN npm install && \
    grunt && \
    cd dist && \
    npm install --production && \
    rm -rf ../node_modules ../build && \
    npm cache clean

RUN chmod +x /dashkiosk/entrypoint.sh

# We use SQLite by default. If you want to keep the database between
# runs, don't forget to provide a volume for /database.
VOLUME /database

ENV NODE_ENV production
ENV port 8080
ENV db__options__storage /database/dashkiosk.sqlite

ENTRYPOINT [ "/dashkiosk/entrypoint.sh" ]
EXPOSE 8080
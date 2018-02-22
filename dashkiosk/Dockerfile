FROM arm32v7/node
MAINTAINER Robert Doering <rdoering.info@gmail.com>

RUN npm install --global bower grunt-cli
RUN apt-get -qq update && apt-get install -qq \
	gifsicle \
	libjpeg-progs \
	optipng \
	libavahi-compat-libdnssd-dev \
	avahi-utils

WORKDIR /dashkiosk
COPY ./dashkiosk /dashkiosk/
RUN rm -rf /dashkiosk/.git

ENV NPM_CONFIG_LOGLEVEL warn
RUN npm install 
RUN grunt
RUN cd dist && npm install --production
RUN rm -rf node_modules build
RUN npm cache clean --force

RUN chmod +x /dashkiosk/entrypoint.sh

# We use SQLite by default. If you want to keep the database between
# runs, don't forget to provide a volume for /database.
VOLUME /database

ENV NODE_ENV production
ENV port 8080
ENV db__options__storage /database/dashkiosk.sqlite

ENTRYPOINT [ "/dashkiosk/entrypoint.sh" ]
EXPOSE 8080

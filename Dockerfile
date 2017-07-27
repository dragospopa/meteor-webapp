# Generated by Cloud66 Starter

FROM node:4.8.2

# setup user home dir
ENV USER node
ENV HOME_DIR /home/$USER
RUN mkdir -pv /home/$USER 
RUN chown $USER:$USER /home/$USER

# setup application dir
ENV APP_HOME /app
RUN mkdir -pv $APP_HOME
RUN chown $USER:$USER $APP_HOME

# run next commands as user deamon
USER $USER
ENV HOME /home/$USER
ENV PATH $PATH:$HOME/.meteor

# install meteor (for building distribution)
RUN curl -sL https://install.meteor.com/?release=1.5 | /bin/sh

# setup temp dir for building meteor distribution
USER root
RUN cp "/home/node/.meteor/packages/meteor-tool/1.5.0/mt-os.linux.x86_64/scripts/admin/launch-meteor" /usr/bin/meteor

#install required packages (magick)
RUN apt-get update 
RUN apt-get install apt-utils -y
RUN apt-get install imagemagick libmagick++-dev  libmagick++-6.q16-dev -y
ENV PATH /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16:$PATH

ENV APP_TMP /tmp
#WORKDIR $APP_TMP
#COPY . $APP_TMP
#RUN chown -R $USER:$USER $APP_TMP
USER $USER

# set NPM stuff
ENV NODE_ENV production
ENV NPM_CONFIG_LOGLEVEL warn
ENV ROOT_URL http://www.example.com
COPY . /app/
RUN (cd programs/server && npm install --unsafe-perm)
# ADD CUSTOM REGISTRY HERE IF REQUIRED
# ENV CUSTOM_REGISTRY https://registry.npmjs.org/ 
# RUN npm config set strict-ssl false
# RUN npm config set registry $CUSTOM_REGISTRY

#install npm packages first
RUN meteor npm install

# build the distribution and deploy in app dir
RUN meteor build --server-only --architecture=os.linux.x86_64 build
RUN tar -xf build/tmp.tar.gz --strip-components=1 -C $APP_HOME

# WORKDIR $APP_HOME

# install NPM packages
#RUN cd programs/server
#RUN npm install

CMD node main.js


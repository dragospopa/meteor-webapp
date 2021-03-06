FROM node:latest

RUN apt-get install -y curl
RUN curl https://install.meteor.com/?release=1.5 | /bin/sh
# Change "budgeter" to your app's name 
ADD . /opt/meteor-webapp/app
# Install NPM packages
WORKDIR /opt/meteor-webapp/app/

RUN meteor build --directory build --server-only --allow-superuser

WORKDIR /opt/meteor-webapp/app/build/bundle/programs/server
RUN npm install 

# Set environment variables 
WORKDIR /opt/meteor-webapp/app
ENV PORT 80
ENV ROOT_URL http://www.example.com
ENV MONGO_URL mongodb://mongo_instance:27017/meteor-webapp
# Expose port 80
EXPOSE 80
WORKDIR /opt/meteor-webapp/app

# Start the app


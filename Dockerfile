FROM node:4.8.2

RUN apt-get install -y curl
RUN curl https://install.meteor.com/ | /bin/sh
# Change "budgeter" to your app's name 
ADD . /opt/microscope/app
# Install NPM packages
WORKDIR /opt/microscope/app/

RUN meteor build --directory build --server-only
WORKDIR /opt/microscope/app/build/bundle/programs/server
RUN npm install 

# Set environment variables 
WORKDIR /opt/microscope/app
ENV PORT 80
ENV ROOT_URL http://www.example.com
ENV MONGO_URL mongodb://mongo_instance:27017/microscope
# Expose port 80
EXPOSE 80

# Start the app
CMD node ./main.js

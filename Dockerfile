FROM jshimko/meteor-launchpad:latest

ENV ROOT_URL http://www.example.com
ENV MONGO_URL mongodb://url
ENV MONGO_OPLOG_URL mongodb://oplog_url
ENV PORT 3000

EXPOSE 3000

CMD ls 
#CMD node server/main.js

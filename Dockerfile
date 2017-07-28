FROM jshimko/meteor-launchpad:latest

ENV ROOT_URL http://www.example.com
ENV PORT 3000

EXPOSE 3000

CMD ls 
CMD node server/main.js

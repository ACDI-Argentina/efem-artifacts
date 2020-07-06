FROM node:10.21.0-buster

WORKDIR /usr/src/app

#The following line is only for debug purposes
RUN apt-get update && apt-get install telnet -y

#Rather than copying the entire working directory, we are only copying the package.json file. 
#This allows us to take advantage of cached Docker layers
ADD app/package*.json .

RUN npm install
RUN npm install pm2 -g

ADD app .

ADD ecosystem.config.js .

EXPOSE 3030

CMD [ "pm2-runtime", "start", "ecosystem.config.js" ]

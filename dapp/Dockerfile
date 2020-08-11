FROM node:10.21.0-buster

WORKDIR /usr/src/app

#Rather than copying the entire working directory, we are only copying the package.json file. 
#This allows us to take advantage of cached Docker layers
ADD app/package*.json ./

RUN npm install

ADD app .

#La configuración se va a establecer haciendo uso de un bind mount
#ADD config/configuration.js src

EXPOSE 3010

CMD ["npm","start"]


# base image
FROM node:latest

# install chrome for protractor tests
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH
ENV NODE_OPTIONS=--openssl-legacy-provider

# install and cache app dependencies
COPY package.json /app/package.json
RUN npm install -g @angular/cli
RUN npm install --force 

# add app
COPY . /app

EXPOSE 4200

# start app
CMD ng serve --host 0.0.0.0

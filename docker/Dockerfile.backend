FROM node:16-alpine

# Bundle APP files
COPY server/ server/
COPY package.json .
COPY pm2.json .
COPY yarn.lock .
RUN npm config set registry https://registry.npmmirror.com
RUN yarn install
RUN npm install pm2 -g
# Install app dependencies
ENV NPM_CONFIG_LOGLEVEL warn
# RUN npm install --production

# Show current folder structure in logs
# RUN ls -al -R

CMD [ "pm2-runtime", "start", "pm2.json" ]

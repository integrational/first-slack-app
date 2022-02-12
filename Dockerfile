FROM    node:current-alpine
# upgrade npm to latest to avoid warnings
RUN     npm install -g npm
WORKDIR /app
COPY    *.js *.json ./
COPY    node_modules node_modules
EXPOSE  3000
# run via npm for graceful interrupt
CMD     ["npm","start"]

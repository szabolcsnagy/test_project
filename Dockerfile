FROM node:13-alpine

WORKDIR /srv/test_project

# copy the current project to the work directory
COPY . .
# EXPOSE 3000
# install dependencies
RUN yarn install
# start
CMD node src/index.js
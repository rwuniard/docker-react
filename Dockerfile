# This is a builder phase to build the build directory
# Comment it out below to fix an issue with elasticbeanstalk
# FROM node:alpine as builder 
# This is a quickfix to not name the stage -> Look at section 7, 102 notes
FROM node:alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# This is the run phase with Nginx. It will copy the /build directory to Nginx container.
FROM nginx
EXPOSE 80
# this means copying from the builder the /app/build folder to the nginx /usr/share/nginx/html
# the nginx folder can be found from nginx doc: https://hub.docker.com/_/nginx
# Comment it out below to fix an issue with elasticbeanstalk
# COPY --from=builder /app/build /usr/share/nginx/html
# This is the quick fix -> Look at section 7, 102 notes
COPY --from=0 /app/build /usr/share/nginx/html
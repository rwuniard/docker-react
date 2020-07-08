# this is a builder phase to build the build directory
FROM node:alpine as builder 
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# This is the run phase with Nginx. It will copy the /build directory to Nginx container.
FROM nginx
EXPOSE 80
# this means copying from the builder the /app/build folder to the nginx /usr/share/nginx/html
# the nginx folder can be found from nginx doc: https://hub.docker.com/_/nginx
COPY --from=builder /app/build /usr/share/nginx/html
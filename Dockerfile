## Build Phase
FROM node:10.15-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

## Run Phase
FROM nginx
EXPOSE 80
## We want to copy something from a different phase which is builder here 
COPY --from=builder /app/build /usr/share/nginx/html 
## The default command will start nginx, so we don't have to explicitly add CMD
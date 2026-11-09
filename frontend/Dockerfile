#Dockerfile de desarrollo 1.0 (en /frontend junto con el resto del servicio)

FROM node:22-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
EXPOSE 5173
COPY . .
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]




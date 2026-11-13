# Development Dockerfile 1.0 (in /frontend alongside the rest of the service)

FROM node:22-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
EXPOSE 5173
COPY . .
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]




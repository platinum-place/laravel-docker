
# ----------------------
# Stage 1: Build Frontend Assets
# ----------------------
FROM node:22-alpine AS frontend

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY vite.config.js ./
COPY resources ./resources
COPY public ./public

RUN npm run build

# ----------------------
# Stage 2: Nginx
# ----------------------
FROM nginx:alpine

COPY docker/prod/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY public /var/www/html/public
COPY --from=frontend /app/public/build /var/www/html/public/build

# Create storage symlink
RUN ln -sf /var/www/html/storage/app/public /var/www/html/public/storage

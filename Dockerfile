# Final Railway-ready Dockerfile for CypherX
FROM node:20-bullseye

# Install system libraries & build tools required for native modules
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential g++ make python3 git curl ca-certificates \
    ffmpeg imagemagick webp \
    libsqlite3-dev libssl-dev libc6-dev libpng-dev libjpeg-dev zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files first to use Docker cache
COPY package*.json ./

# Install Node dependencies (force + unsafe-perm + build from source)
RUN npm install --build-from-source --unsafe-perm --force && npm cache clean --force

# Copy full app
COPY . .

# Expose port (Railway will map)
EXPOSE 3000

# Production env
ENV NODE_ENV=production

# Run the serve script (keeps container alive + loads index.js)
CMD ["npm", "run", "serve"]
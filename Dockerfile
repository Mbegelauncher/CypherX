FROM node:20

# Install full build environment for native modules
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg imagemagick webp \
    build-essential python3 make g++ git libc6-dev \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Force install all dependencies from source
RUN npm install --build-from-source --unsafe-perm && npm cache clean --force

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Set environment
ENV NODE_ENV=production

# Run the bot
CMD ["npm", "run", "serve"]
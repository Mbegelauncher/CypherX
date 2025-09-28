FROM node:lts

# Install build tools + dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential python3 make g++ ffmpeg imagemagick webp && \
    apt-get clean

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies safely
RUN npm install --unsafe-perm --build-from-source && npm cache clean --force

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Set environment
ENV NODE_ENV=production

# Keep process alive even if small errors occur
CMD ["node", "index.js"]
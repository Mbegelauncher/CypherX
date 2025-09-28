FROM node:20

# Install build tools for native modules
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential python3 g++ make ffmpeg imagemagick webp && \
    apt-get clean

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies safely
RUN npm install --unsafe-perm --build-from-source || true
RUN npm rebuild || true

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Environment
ENV NODE_ENV=production

# Run bot
CMD ["node", "index.js"]
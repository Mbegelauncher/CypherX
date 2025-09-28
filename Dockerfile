# -------------------------
# Cypher X WhatsApp Bot Dockerfile
# Ready for Railway deployment
# -------------------------

# Use latest LTS Node version
FROM node:lts

# Install required Linux dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        imagemagick \
        webp \
        build-essential \
        python3 \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first (for caching)
COPY package*.json ./

# Install dependencies with unsafe-perm to handle native modules
RUN npm install --unsafe-perm --force && npm cache clean --force

# Copy the rest of the bot code
COPY . .

# Expose port (optional, depending on Railway)
EXPOSE 3000

# Set environment variable for production
ENV NODE_ENV=production

# Start the bot
CMD ["npm", "start"]
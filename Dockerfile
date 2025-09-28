FROM node:20-bullseye

# Install all system dependencies needed for Node native modules
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg imagemagick webp \
    build-essential python3 make g++ git \
    libc6-dev libsqlite3-dev libssl-dev curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies from source with full permissions
RUN npm install --build-from-source --unsafe-perm && npm cache clean --force

# Copy full application
COPY . .

# Expose port (if your bot uses it)
EXPOSE 3000

# Set production environment
ENV NODE_ENV=production

# Fix platform detection for Windows emulation if needed
RUN node -e "Object.defineProperty(process, 'platform', { value: 'win32' });"

# Run the bot
CMD ["npm", "run", "serve"]
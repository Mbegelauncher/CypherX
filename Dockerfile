# Use Node 20 LTS
FROM node:20-bullseye

# Install all necessary system dependencies for native modules
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential g++ make python3 git curl \
    ffmpeg imagemagick webp \
    libsqlite3-dev libssl-dev libc6-dev \
    libpng-dev libjpeg-dev zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install all dependencies from package.json
RUN npm install --build-from-source --unsafe-perm && npm cache clean --force

# Copy all app code
COPY . .

# Override platform to Windows to prevent crashes
RUN node -e "Object.defineProperty(process, 'platform', { value: 'win32' });"

# Expose port if bot uses any
EXPOSE 3000

# Set production environment
ENV NODE_ENV=production

# Run the bot
CMD ["npm", "run", "start"]
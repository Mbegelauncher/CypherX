FROM node:20-bullseye

# Install all necessary system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential g++ make python3 git curl \
    ffmpeg imagemagick webp \
    libsqlite3-dev libssl-dev libc6-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --build-from-source --unsafe-perm && npm cache clean --force

# Copy all app code
COPY . .

# Override platform to Windows if needed
RUN node -e "Object.defineProperty(process, 'platform', { value: 'win32' });"

# Expose port if bot uses it
EXPOSE 3000

# Set environment
ENV NODE_ENV=production

# Run bot
CMD ["npm", "run", "serve"]
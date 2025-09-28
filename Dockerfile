FROM node:20

# Install dependencies (full toolchain for sqlite3 / better-sqlite3)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg imagemagick webp \
    build-essential python3 make g++ \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install node modules
RUN npm install --build-from-source && npm cache clean --force

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Set environment
ENV NODE_ENV=production

# Run command
CMD ["npm", "run", "serve"]
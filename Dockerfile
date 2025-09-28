FROM node:20

# Install dependencies (including build tools for sqlite3 / better-sqlite3)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg imagemagick webp build-essential python3 \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install && npm cache clean --force

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Set environment
ENV NODE_ENV=production

# Run command
CMD ["npm", "run", "serve"]
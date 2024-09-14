# Use the official Node.js image.
FROM node:18

# Install necessary dependencies.
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright and Lighthouse.
RUN npm install -g playwright lighthouse

# Create a working directory.
WORKDIR /app

# Copy package.json and install dependencies.
COPY package.json ./
RUN npm install

# Copy the rest of the application code.
COPY . .

# Run the entrypoint script.
ENTRYPOINT ["/app/entrypoint.sh"]

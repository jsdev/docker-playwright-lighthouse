# Use the official Playwright image.
FROM mcr.microsoft.com/playwright/playwright:latest

# Install Lighthouse.
RUN npm install -g lighthouse

# Create a working directory.
WORKDIR /app

# Copy package.json and install dependencies.
COPY package.json ./
RUN npm install

# Copy the rest of the application code.
COPY . .

# Ensure the entrypoint script is executable.
RUN chmod +x /app/entrypoint.sh

# Run the entrypoint script.
ENTRYPOINT ["/app/entrypoint.sh"]

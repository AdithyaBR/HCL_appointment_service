FROM node:18-alpine
# Set work directory
WORKDIR /app
# Install the dependencies
COPY package*.json ./
RUN npm install #--production
# Copy appl code
COPY . .
# Expose port
EXPOSE 3001
# Run the app
CMD ["node", "index.js"]

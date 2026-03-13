FROM maven:3.9-openjdk-17

# Install git
RUN apt-get update && apt-get install -y git

# Set working directory
WORKDIR /workspace

# Copy project files
COPY . .

# Install dependencies
RUN mvn clean install -DskipTests

# Expose port for reports
EXPOSE 8080

# Default command
CMD ["bash"]

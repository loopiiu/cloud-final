# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install system dependencies (required for certain Python packages that need compiling)
RUN apt-get update && apt-get install -y build-essential libpq-dev

# Upgrade pip and verify its version
RUN pip install --upgrade pip && pip --version

# List the content of requirements.txt to verify that it's being copied correctly
RUN cat requirements.txt

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt --verbose

# Expose port 8080 for the app to run
EXPOSE 8080

# Run the application (replace this with your actual start command)
CMD ["python", "app.py"]

FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the content of the local directory to /app in the container
COPY . /app

# Upgrade pip and verify its version
RUN pip install --upgrade pip && pip --version

# Install dependencies (without pip list) to isolate the error
RUN pip install --no-cache-dir -r requirements.txt

# Expose port for the app
EXPOSE 8080

# Run the application (if applicable, adjust to your app entry point)
CMD ["python", "app.py"]

# Use an official Python runtime as a parent image
FROM python:3.11-slim-buster  
# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8080 available to the world outside this container
EXPOSE 8080

# # Define environment variable
# ENV NAME World
# Run app.py when the container launches python hello_app/main.py
CMD [ "python", "main.py"]

# docker build . -t hello-app:latest
# docker run -p 8080:8080 hello-app:latest
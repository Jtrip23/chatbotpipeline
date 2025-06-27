# Use an official Python runtime as a parent image
# FROM nexus.onefiserv.net/python:3.9-slim

ARG BASE_REGISTRY=fmk.nexus.onefiserv.net

ARG BASE_IMAGE=fmk/python/python-3.9

ARG BASE_TAG=FMK-01-10-24

ARG FMK_BASE_IMAGE=${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

FROM ${FMK_BASE_IMAGE}

USER root

# Copy the current directory contents into the container at /app
COPY . /app

# Set the working directory in the container
WORKDIR /app

# Install any needed packages specified in requirements.txt

COPY requirements.txt ./
ADD requirements.txt /app/
RUN python -m pip install -r requirements.txt
#python -m pip install --no-cache-dir -r requirements.txt

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run app.py when the container launches
CMD ["streamlit", "run", "app.py", "--server.port=8080"]

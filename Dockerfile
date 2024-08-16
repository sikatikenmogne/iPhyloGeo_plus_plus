# Use an official Python runtime as a parent image
FROM mcr.microsoft.com/devcontainers/python:3.10


# Install system dependencies for PyQt, QtWebEngine, and Ghostscript
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    qttools5-dev-tools \
    libglib2.0-0 \
    libgl1-mesa-glx \
    libegl1-mesa \
    libxext6 \
    libxrender1 \
    libfontconfig1 \
    libx11-6 \
    ghostscript \
    && apt-get install -y --no-install-recommends \
    qtwebengine5-dev \
    xvfb \
    x11-apps \
    libxcomposite1 \
    libxrandr2 \
    libxtst6 \
    libxkbcommon0 \
    xauth \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the locally cloned repository into the Docker image
COPY . /usr/src/app/iPhyloGeo_plus_plus

# Change the working directory to the copied repository
WORKDIR /usr/src/app/iPhyloGeo_plus_plus

# Set PYTHONPATH to include the directory where 'scripts' is located
# ENV PYTHONPATH="${PYTHONPATH}:/usr/src/app/iPhyloGeo_plus_plus"

# Copy the requirements.txt file into the Docker image
COPY ./requirements.txt .

# Install the required Python packages specified in requirements.txt
# Ensure to include PyQtWebEngine
RUN pip install --default-timeout=1000 --no-cache-dir -r requirements.txt PyQtWebEngine

# Install PyQt5 tools
RUN pip install pyqt5-tools

# Create the start.sh script
RUN echo '#!/bin/bash\n\ncd scripts\n\npython3 main.py' > /usr/src/app/iPhyloGeo_plus_plus/start.sh

# Make the start.sh script executable
RUN chmod +x /usr/src/app/iPhyloGeo_plus_plus/start.sh

CMD ["/usr/src/app/iPhyloGeo_plus_plus/start.sh"]

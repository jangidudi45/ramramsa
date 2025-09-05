FROM python:3.9-slim-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        gcc \
        libffi-dev \
        musl-tools \
        ffmpeg \
        aria2 \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app/

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Start app
CMD gunicorn app:app & python3 main.py

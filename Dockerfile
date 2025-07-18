# Use updated Debian base to avoid 404 errors
FROM python:3.10.8-slim-bullseye

# Install system packages
RUN apt update && apt upgrade -y && \
    apt install git -y && \
    apt clean

# Copy and install Python dependencies
COPY requirements.txt /requirements.txt
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r /requirements.txt

# Set working directory
WORKDIR /VJ-Forward-Bot

# Copy all project files
COPY . .

# Start the app (gunicorn in background, then main.py)
CMD sh -c "gunicorn app:app & python3 main.py"

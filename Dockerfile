# Base stage with common dependencies
FROM python:3-slim AS base

# Development container stage
FROM base AS devcontainer

# Install system dependencies if needed
RUN apt-get update && apt-get install -y \
        git \
        curl &&\
    rm -rf /var/lib/apt/lists/*

# Deploy stage
FROM base AS deploy

# Set working directory
WORKDIR /app

# Copy requirements and source code
COPY . .

# Install the package
RUN pip install .
# Set working directory
WORKDIR /app

# Expose the default port
EXPOSE 8420

# Run localstripe with unbuffered output
CMD ["python", "-u", "-m", "localstripe"]
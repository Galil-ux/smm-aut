# Use official Python slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies (needed for Playwright)
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs libnss3 libatk1.0-0 libatk-bridge2.0-0 \
        libcups2 libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 \
        libxrandr2 libgbm1 libasound2 && \
    rm -rf /var/lib/apt/lists/*

# Install Playwright browsers
RUN npx playwright install-deps && \
    npx playwright install chromium

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY . .

# Expose port
EXPOSE 8000

# Run the app
CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8000"]

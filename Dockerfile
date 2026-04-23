FROM python:3.11-slim

WORKDIR /app

# Playwright dependencies install
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-6 \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright
RUN pip install playwright==1.40.0
RUN playwright install chromium
RUN playwright install-deps

# Install Python dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy bot
COPY bot.py .

# Set environment variables
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
ENV PYTHONUNBUFFERED=1

CMD ["python3", "bot.py"]
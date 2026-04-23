FROM python:3.10-slim

WORKDIR /app

# Playwright dependencies for headless mode
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright browser
RUN playwright install chromium

# Copy bot files
COPY bot.py .
COPY cli_list.json .
COPY range_data.json .

# Run bot
CMD ["python", "bot.py"]

# Use a more recent Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy the project files
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip setuptools wheel
RUN pip install --no-cache-dir tox pytest hypothesis

# Install Twisted in editable mode with all dependencies
RUN pip install -e .[all_non_platform,dev_release]

# Set environment variables
ENV PYTHONPATH=/app/src:$PYTHONPATH
ENV CFLAGS="-fno-strict-aliasing -fno-common -dynamic -pipe -fno-common -fPIC"
ENV LDFLAGS="-Wl,-O1 -Wl,--as-needed"

# Create a script to run the specific tests
RUN echo '#!/bin/bash\n\
python -m twisted.trial \
    --reporter=verbose \
    --tbformat=verbose \
    --no-recurse \
    --without-module=twisted.internet.asyncioreactor \
    --without-module=twisted.internet.gireactor \
    --without-module=twisted.internet.gtk3reactor \
    --without-module=twisted.internet.pyuireactor \
    --without-module=twisted.internet.wxreactor \
    src/twisted/web/test/test_xml.py \
    src/twisted/web/test/test_domhelpers.py\n\
exit $?' > /app/run_tests.sh && chmod +x /app/run_tests.sh

# Set the entry point to run the tests
ENTRYPOINT ["/app/run_tests.sh"]

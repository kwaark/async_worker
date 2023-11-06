# async_worker/Dockerfile
FROM base_image:latest

WORKDIR /app

# Copy project files to the /app directory
COPY . .

# Install dependencies
RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

# Define the ENTRYPOINT to start the application "poetry", "run", 
ENTRYPOINT ["faust", "-A", "app", "worker", "-l", "info"]

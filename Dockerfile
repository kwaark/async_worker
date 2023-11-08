# async_worker/Dockerfile
FROM kwaark/base_image:v1.0

# Define working directory
WORKDIR /app

# Install git
RUN apt-get update && \
    apt-get install -y git

# Clone the repository
RUN git clone https://github.com/kwaark/async_worker.git .

# Install dependencies
RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

# Define the ENTRYPOINT to start the application "poetry", "run", 
ENTRYPOINT ["faust", "-A", "app", "worker", "-l", "info"]

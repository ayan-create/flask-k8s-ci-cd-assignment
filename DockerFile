# Stage 1: Build base image
FROM python:3.10-slim AS builder

WORKDIR /app
COPY Requirements.txt .
RUN pip install --no-cache-dir -r Requirements.txt

# Stage 2: Final image
FROM python:3.10-slim

WORKDIR /app
COPY --from=builder /usr/local/lib/python3.10 /usr/local/lib/python3.10
COPY app.py .

EXPOSE 5000
CMD ["python", "app.py"]

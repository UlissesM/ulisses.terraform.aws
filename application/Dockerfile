FROM python:3.11-alpine

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r /app/requirements.txt

# Command to run the application
CMD ["python", "main.py"]
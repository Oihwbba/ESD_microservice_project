
FROM python:3.10-slim

WORKDIR /app
# relative to docker build file
COPY driver/driver.py . 

COPY http.reqs.txt .

RUN pip install --no-cache-dir -r http.reqs.txt

CMD ["python", "driver.py"]

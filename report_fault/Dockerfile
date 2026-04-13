FROM python:3.10

WORKDIR /app
COPY http.reqs.txt .
COPY report_fault/report_fault.py .
COPY amqp_lib.py invokes.py ./

RUN pip install --no-cache-dir -r http.reqs.txt

CMD ["python", "report_fault.py"]
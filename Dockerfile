FROM python:3.9-slim

WORKDIR /app

COPY sample-code.py .

RUN pip install flask

CMD ["python", "sample-code.py"]

EXPOSE 5000

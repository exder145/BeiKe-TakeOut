FROM python:3.9.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 9090

CMD ["python", "app.py"] 
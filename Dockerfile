FROM python:3.9-slim

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

RUN chown -R appuser:appuser /app

USER appuser

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:5000/ || exit 1

CMD [ "python" "app.py" ]
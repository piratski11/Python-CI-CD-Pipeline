FROM python:3.-alpine
WORKDIR /app
COPY requirements.txt .
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt  

FROM builder as tester 
COPY . .
RUN pytest tests/ -v

FROM python:3.11-alpine as runtime 
RUN apk add --no-cache curl 
COPY --from=builder /opt/venv /opt/venv
WORKDIR /app 
COPY main.py .
ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONUNBUFFERED=1
RUN adduser -D appuser && chown -R appuser /app 
USER appuser
EXPOSE 8000
CMD ["python", "main.py"]
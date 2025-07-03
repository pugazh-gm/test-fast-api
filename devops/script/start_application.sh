#!/bin/bash
echo "Starting FastAPI app..."

cd /home/ubuntu/fastapi-app
source venv/bin/activate
nohup uvicorn app.main:app --host 0.0.0.0 --port 8000 > app.log 2>&1 &

#!/bin/bash
echo "Starting FastAPI app..."
source venv/bin/activate
uvicorn app.main:app --host 0.0.0.0 --port 8000

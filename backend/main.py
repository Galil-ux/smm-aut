from fastapi import FastAPI
import os
import logging

app = FastAPI(title="Kids Fashion Automator")
logger = logging.getLogger("uvicorn")

@app.get("/health")
def health():
    db_url = os.getenv("DATABASE_URL")
    db_ok = False
    if db_url:
        try:
            import psycopg2
            conn = psycopg2.connect(db_url)
            conn.close()
            db_ok = True
        except Exception as e:
            logger.warning(f"DB connection failed: {e}")
    
    return {
        "status": "ok",
        "service": "smm-aut",
        "db_configured": bool(db_url),
        "db_connectable": db_ok
    }
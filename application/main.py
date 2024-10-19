from fastapi import FastAPI
from pydantic import BaseModel
import os

app = FastAPI()

# Environment variables
SERVICE_NAME = os.getenv("SERVICE_NAME", "default service")
PORT = int(os.getenv("PORT", 5000))  # Default to port 5000 if not specified

class TestResponse(BaseModel):
    message: str

@app.get("/health")
def health():
    return {"status": "healthy"}

@app.get("/test", response_model=TestResponse)
@app.post("/test", response_model=TestResponse)
def test():
    return {"message": f"hello world service name {SERVICE_NAME}"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=PORT)

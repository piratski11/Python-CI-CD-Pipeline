from fastapi import FastApi 

app = FastApi()

@app.get("/")
def read_root():
    return {"message", "zdarova brat"}

@app.get("/health")
def health_check():
    return {"status": "OK"}

@app.get("/users/{user_id}")
def get_user(user_id: int):
    return {"user_id": user_id, "name": f"User {user_id}"}

if __name__ == "__main__":
    import uvicorn 
    uvicorn.run(app, host="0.0.0.0", port=8000)
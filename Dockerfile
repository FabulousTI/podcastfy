FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y python3-full python3-pip git ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Cloner ton repo (remplace par ton URL si nécessaire)
RUN git clone https://github.com/tonusername/podcastfy.git /app
WORKDIR /app

# Installer requirements si ton repo les fournit
# RUN pip install -r requirements.txt
# Ou installer directement si pas de requirements.txt
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN python3 -m pip install --upgrade pip
RUN pip install --no-cache-dir -e .

RUN pip install uvicorn

ENV PYTHONUNBUFFERED=1

CMD ["uvicorn", "podcastfy.api.fast_app:app", "--host", "0.0.0.0", "--port", "8000"]

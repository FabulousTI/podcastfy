FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y python3-full python3-pip ffmpeg && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN python3 -m pip install --upgrade pip
COPY . /app
WORKDIR /app
RUN pip install --no-cache-dir uvicorn
RUN pip install --no-cache-dir -e .

ENV PYTHONUNBUFFERED=1

CMD ["uvicorn", "podcastfy.api.fast_app:app", "--host", "0.0.0.0", "--port", "8000"]

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Installer dépendances système
RUN apt-get update && \
    apt-get install -y python3-full python3-pip ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Créer et activer un environnement virtuel
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Mettre à jour pip
RUN python3 -m pip install --upgrade pip

# Installer podcastfy et uvicorn
RUN pip install --no-cache-dir podcastfy uvicorn

ENV PYTHONUNBUFFERED=1

# Démarrage de l'application
CMD ["uvicorn", "podcastfy.fast_app:app", "--host", "0.0.0.0", "--port", "8000"]

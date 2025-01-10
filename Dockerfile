# 1. Image de base
FROM python:3.6-alpine

#Maintainer 
LABEL maintainer="MDI"

# 2. Définir le répertoire de travail /opt
WORKDIR /opt

# 3. Installer le module Flask
RUN pip install flask==1.1.2

# 4. Exposer le port 8080
EXPOSE 8080

# Lire et exporter les valeurs des variables d'environnement
RUN set -a && \
    . /releases.txt && \
    echo "ODOO_URL=$ODOO_URL" >> /etc/environment && \
    echo "PGADMIN_URL=$PGADMIN_URL" >> /etc/environment

# 5. Définir les variables d'environnement
ENV ODOO_URL=${ODOO_URL}
ENV PGADMIN_URL=${PGADMIN_URL}

# 6. Copier le fichier de l'application dans l'image (assurez-vous que app.py est dans le même dossier que le Dockerfile)
COPY app.py .

# 7. Lancer l'application Flask
CMD ["python", "app.py"]

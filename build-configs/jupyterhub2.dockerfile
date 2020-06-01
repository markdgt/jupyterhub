FROM quay.io/jupyteronopenshift/jupyterhub:latest

# Install dockerspawner, oauth, postgres
RUN pip install psycopg2-binary --upgrade && \
    pip install --no-cache-dir \
        jupyterhub-ltiauthenticator \
        nbgrader \
        rudaux 
FROM quay.io/jupyteronopenshift/jupyterhub:latest

# Install dockerspawner, oauth, postgres
RUN /usr/local/bin/pip3.6 install psycopg2-binary --upgrade && \
    /usr/local/bin/pip3.6 install --no-cache-dir \
        jupyterhub-ltiauthenticator \
        nbgrader \
        rudaux 
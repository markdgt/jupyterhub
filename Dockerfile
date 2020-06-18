FROM registry.centos.org/centos/python-36-centos7

LABEL io.k8s.display-name="JupyterHub" \
      io.k8s.description="JupyterHub." \
      io.openshift.tags="builder,python,jupyterhub" \
      io.openshift.s2i.scripts-url="image:///opt/app-root/builder"

USER root
#Test1
RUN rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
RUN yum install -y https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
RUN yum --enablerepo=elrepo-kernel install -y kernel-lt
RUN yum update -y
COPY . /tmp/src

RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src && \
    mv /tmp/src/.s2i/bin /tmp/scripts

USER 1001

ENV NPM_CONFIG_PREFIX=/opt/app-root \
    PYTHONPATH=/opt/app-root/src

RUN /tmp/scripts/assemble

CMD [ "/opt/app-root/builder/run" ]

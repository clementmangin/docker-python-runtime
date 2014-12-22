#
# Python runtime Dockerfile
#
# https://github.com/dockerfile/python-runtime
#

# Pull base image.
FROM dockerfile/python

# Set instructions on build.
ONBUILD ADD apt-requirements.txt /app/
ONBUILD RUN \
  apt-get update && \
  cat /app/apt-requirements.txt | xargs apt-get install -y && \
  rm -rf /var/lib/apt/lists/*
ONBUILD RUN virtualenv /env
ONBUILD ADD requirements.txt /app/
ONBUILD RUN /env/bin/pip install -r /app/requirements.txt
ONBUILD ADD . /app

# Define working directory.
WORKDIR /app

# Define default command.
CMD ["/env/bin/python", "main.py"]

# Expose ports.
EXPOSE 8080

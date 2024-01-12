FROM continuumio/miniconda3

RUN apt-get -qq update && \
  apt-get -qy install -f \
  ffmpeg \
  libsm6 \
  libxext6 \
  # Install zsh so it can source my local config
  zsh

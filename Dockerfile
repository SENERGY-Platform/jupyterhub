FROM quay.io/jupyterhub/k8s-singleuser-sample:3.3.6

USER root 
RUN apt-get update

RUN apt-get install -y wget && apt-get install -y curl

RUN apt-get install -y build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

WORKDIR /home/jovyan
RUN mkdir -p ./miniconda3 \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ./miniconda3/miniconda.sh \
    && bash ./miniconda3/miniconda.sh -b -u -p ./miniconda3 \
    && rm -rf ./miniconda3/miniconda.sh

ENV PATH="/home/jovyan/miniconda3/bin:${PATH}"
ARG PATH="/home/jovyan/miniconda3/bin:${PATH}"

RUN conda --version

RUN curl https://pyenv.run | bash
ENV PYENV_ROOT="$HOME/.pyenv" 
ENV PATH="$PYENV_ROOT/bin:$PATH"

RUN pyenv install 3.8

COPY install_kernel.sh .
RUN chmod +x install_kernel.sh
RUN ./install_kernel.sh


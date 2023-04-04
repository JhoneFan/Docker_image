# Base image with CUDA and Ubuntu
FROM nvidia/cuda:11.2.0-cudnn8-devel-ubuntu18.04

# Prevent interactive prompts from apt-get
ARG DEBIAN_FRONTEND=noninteractive

# Install required public keys
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC

# Update and install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        software-properties-common \
        build-essential \
        libssl-dev \
        libffi-dev \
        curl \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        python3.7 \
        python3.7-dev \
        python3.7-distutils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.7 as the default version, then update pip and setuptools
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1 \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3.7 get-pip.py \
    && rm get-pip.py \
    && python3.7 -m pip install --upgrade pip setuptools

# Install TensorFlow 1.15.0, its dependencies and Jupyter
RUN pip install numpy==1.16.4 protobuf==3.20.1 tensorflow-gpu==1.15.0 jupyter

# Install PyTorch 1.9.1 with GPU support
# RUN pip install torch==1.9.1+cu102 -f https://download.pytorch.org/whl/cu102/torch_stable.html
RUN pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

# Expose port 8888 for Jupyter notebook
EXPOSE 8888

# Set working directory
WORKDIR /tf

# Set default command to start Jupyter notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]

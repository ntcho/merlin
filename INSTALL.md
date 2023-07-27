# Installation

## [brew](https://brew.sh/)
  
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/labguest/.zprofile
  eval "$(/usr/local/bin/brew shellenv)"
```

## [miniconda](https://docs.conda.io/en/latest/miniconda.html#latest-miniconda-installer-links)

```bash
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O && bash Miniconda3-latest-*.sh  # use MacOSX-arm64 for Apple Silicon
conda init zsh
rm Miniconda3-latest-*.sh
```

## git

```bash
brew install git
brew link --overwrite git  # overwrites existing git installation
git --version
```

# Configuration

## Merlin

### Git

```bash
git clone https://github.com/ntcho/merlin && cd merlin
git config user.name "Nathan Cho"
git config user.email "ntcho13@gmail.com"
git checkout apple-intel  # use apple-silicon for Apple Silicon
```

### Conda environment

```bash
conda env create -f environment.yml
conda activate merlin
conda install pip
pip install git+https://github.com/MattShannon/bandmat
```

### Merlin toolkit

```bash
brew install cmake coreutils autoconf automake libtool gnu-sed gawk
vi ~/.zprofile  # add `PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"`
bash tools/compile_tools.sh
```

> on macOS, you might need to add `#include <stdlib.h>` on `tools/postfilter/src/mcpf.c` source code to build.

### Dataset config

```bash
code egs/build_your_own_voice/s1/conf/global_settings.cfg  # update utterance counts
```

Symlink (or copy) `.{wav|txt}` files from the dataset to `**/s1/database/{wav|txt}`.

## More advanced instructions

1. go to `tools/`  and follow INSTALL instructions there.
2. Merlin is coded in python and need third-party python libraries such as:

#### numpy, scipy, matplotlib, lxml 

- Usually shipped with your python packages 
- Available in Ubuntu packages

#### theano

- Can be found on pip
- Need version 0.7 and above
- http://deeplearning.net/software/theano

#### bandmat

- Can be found on pip
- https://pypi.python.org/pypi/bandmat

#### For running on NVIDIA GPU, you will need also CUDA

- https://developer.nvidia.com/cuda-zone

#### and you might want also CUDNN [optionnal]

- https://developer.nvidia.com/cudnn

### Computational efficiency
    
- Computationnal efficiency is obviously greatly improved using GPU.
- It is also improved using the latest versions of theano and numpy.

## Some Linux Instructions

#### For Ubuntu: 
```sh
sudo apt-get install python-numpy python-scipy python-dev python-pip python-nose g++ libopenblas-dev git libc6-dev-i386 glibc-devel.i686 csh
```

#### For Fedora: 
```sh
sudo yum install python-numpy python-scipy python-dev python-pip python-nose g++ libopenblas-dev git libc6-dev-i386 glibc-devel.i686 csh python-lxml libxslt-devel unzip
```

#### Common libraries for both Ubuntu and Fedora:
```sh
sudo env "PATH=$PATH" pip install Theano
sudo env "PATH=$PATH" pip install matplotlib
sudo env "PATH=$PATH" pip install bandmat
sudo env "PATH=$PATH" pip install lxml
```

#### For all stand-alone machines:
- If you are not a sudo user, this [post](https://cstr-edinburgh.github.io/install-merlin/) may help you install Merlin.


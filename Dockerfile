# 
# RISV-V Toolchain Dockerfile
#
#
# This is meant to enable RISC-V development via an easy to install
# dockerfile.
# Some initial setup was inspired by Stephen Bates:
#	https://github.com/sbates130272/docker-riscv/blob/master/Dockerfile
#
# Maintained by Bradley Evans


# BASE IMAGE: Ubuntu 18.04 bionic
FROM ubuntu:18.04

MAINTAINER Bradley Evans (bradley-evans) <redacted@redacted.com>

# BASE TOOLS
RUN apt-get update && apt-get install -y \
	autoconf \
	automake \
	autotools-dev \
	libmpc-dev \
	libmpfr-dev\
	libgmp-dev\
	gawk \
	build-essential \
	bison \
	flex \
	texinfo \
	gperf \
	libtool \
	patchutils \
	bc \
	zlib1g-dev \
	libexpat-dev \
	vim \
	curl \
	git \
	python python3 \
	pkg-config libglib2.0-dev libpixman-1-dev


# ENV VARIABLES
ENV RISCV /opt/riscv
ENV NUMJOBS 1
RUN mkdir -p $RISCV
ENV PATH $RISCV/bin:$PATH

# Obtain riscv-gnu-toolchain
WORKDIR $RISCV
RUN git clone -n https://github.com/riscv/riscv-gnu-toolchain.git
WORKDIR $RISCV/riscv-gnu-toolchain
RUN git checkout 2e334e2		# most recent successful riscv-gnu-toolchain build as of 20190819
RUN git submodule update --init --recursive
RUN ./configure --prefix=$RISCV && make linux	# default 64bit build

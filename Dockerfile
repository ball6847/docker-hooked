FROM frolvlad/alpine-python2

COPY . /

RUN pip install hooked waitress

EXPOSE 8888

ENTRYPOINT ["hooked", "/server.cfg"]

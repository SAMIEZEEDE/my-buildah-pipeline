 FROM alpine
RUN echo "Hello from Buildah" > /hello.txt
CMD ["cat", "/hello.txt"]

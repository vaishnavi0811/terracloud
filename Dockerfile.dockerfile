FROM ubuntu:18.04

RUN apt install linuxbrew-wrapper
RUN brew install tfsec
RUN export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin/"


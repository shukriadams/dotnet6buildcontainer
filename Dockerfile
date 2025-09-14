FROM ubuntu:20.04

# squelch tzdata prompt
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install wget -y \
    && apt-get install git -y \
    && apt-get install tzdata -y \
    # python should always be present as a utility runtime
    && apt-get install python3-all -y \
    && wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
    && sh -c 'dpkg -i packages-microsoft-prod.deb' \
    && apt-get install apt-transport-https -y \
    && apt-get update \
    && apt-get install dotnet-sdk-6.0 -y \
    ## clean up
    && rm packages-microsoft-prod.deb \
    && apt-get remove apt-transport-https -y 


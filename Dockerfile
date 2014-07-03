FROM ubuntu:12.04
MAINTAINER xeizmendi@gmail.com

# Install curl
RUN apt-get update
RUN apt-get install -y curl build-essential

ENV NODE_VERSION 0.10.29
# Download node and install it
WORKDIR /opt 
RUN curl http://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz | tar xfz -

# Cleanup installation stuff
RUN apt-get purge -y curl
RUN apt-get autoremove -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create symlinks to node and npm binaries
RUN ln -s /opt/node-v${NODE_VERSION}-linux-x64/bin/* /usr/bin/
# Create symlinks to node libraries
RUN ln -s /opt/node-v${NODE_VERSION}-linux-x64/lib/* /usr/lib/
# Create symlinks to node include files
RUN ln -s /opt/node-v${NODE_VERSION}-linux-x64/include/* /usr/include/

CMD ["/usr/bin/node"]
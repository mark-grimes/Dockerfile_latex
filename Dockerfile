FROM debian:jessie-slim

# vim, less and git not strictly necessary, but make life easier in the container 
RUN apt-get update \
    && apt-get install -y vim less git wget perl

ADD texlive.profile /home/texlive-install-temp/

# Install directly from the texlive installer because even the basic OS packages
# are huge (something like 600Mb for texlive-base)
RUN cd /home/texlive-install-temp \
    && wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    && tar xzf install-tl-unx.tar.gz \
    && rm install-tl-unx.tar.gz \
    && cd ./install-tl* \
    && ./install-tl -profile /home/texlive-install-temp/texlive.profile \
    && cd / \
    && rm -rf /home/texlive-install-temp

# Figuring out this line is basically trial and error. Try and compile your latex project
# and if it comes up with an error like "Missing file glossaries.sty" then just try
# "tlmgr install glossaries". If that doesn't work the file is in a larger package, so do
# a search on https://ctan.org/search/, but note that the most relevant result is often
# not listed first (or even close to the start). 
RUN tlmgr install memoir glossaries xkeyval mfirstuc etoolbox textcase xfor datatool \
                  substr fp xcolor environ trimspaces pgf

WORKDIR /project

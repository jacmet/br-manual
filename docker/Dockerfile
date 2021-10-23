FROM debian:bullseye
RUN apt-get update  && \
    apt-get install -y --no-install-recommends \
	    asciidoc \
	    asciidoc-dblatex \
    	    build-essential \
	    git \
	    rsync \
	    w3m \
	    && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt

# buildroot git tree
VOLUME [ "/buildroot/" ]
# output directory
VOLUME [ "/output/" ]

WORKDIR /buildroot
CMD make O=/output/ manual-html manual-pdf manual-text


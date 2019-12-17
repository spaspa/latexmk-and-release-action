FROM arkark/latexmk:full

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl \
    python3 \
  && rm -rf /var/lib/apt/lists/*


ADD bin/entrypoint.sh /entrypoint.sh
RUN ["cp", "/tmp/latexmk/.latexmkrc", "."]
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]


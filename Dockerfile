FROM splunk/splunk

USER root
RUN mkdir /install/ && chown splunk:splunk /install/
WORKDIR /install/

# Install Node/NPM
RUN wget -q -O setup_8.x https://deb.nodesource.com/setup_8.x
RUN chmod 700 setup_8.x && ./setup_8.x
RUN apt-get install -y nodejs

# Add new entrypoint script
ADD ./entrypoint.sh /install/entrypoint.sh
RUN chown splunk:splunk /install/entrypoint.sh
# Add developer mode settings
ADD conf/web.conf /etc/system/local/web.conf
RUN chown splunk:splunk /etc/system/local/web.conf
# Add sample visualization module
COPY sample_vis /install/sample_vis
RUN chown -R splunk:splunk /install/sample_vis

# swap back to splunk user
USER splunk

ENTRYPOINT ["/bin/bash", "/install/entrypoint.sh"]

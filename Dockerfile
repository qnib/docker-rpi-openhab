FROM qnib/rpi-java8

RUN apt-get install -y bsdtar curl
ENV OH_VER 1.7.1 
ENV OH_TARGET_URL https://bintray.com/artifact/download/openhab/bin
RUN mkdir -p /opt/openhab/ && \
    curl -fsL ${OH_TARGET_URL}/distribution-${OH_VER}-runtime.zip|bsdtar xf - -C /opt/openhab/ && \
    chmod +x /opt/openhab/start.sh
RUN curl -fsL ${OH_TARGET_URL}/distribution-${OH_VER}-addons.zip|bsdtar xf - -C /opt/openhab/addons/
RUN curl -fsL ${OH_TARGET_URL}/distribution-${OH_VER}-greent.zip|bsdtar xf - -C /opt/openhab/webapps/

ADD etc/supervisord.d/*.ini /etc/supervisord.d/
ADD opt/openhab/configurations/ /opt/openhab/configurations/
CMD [ "/opt/openhab/start.sh" ]


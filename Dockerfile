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
ADD opt/qnib/openhab/bin/start.sh /opt/qnib/openhab/bin/
CMD [ "/opt/qnib/openhab/bin/start.sh" ]

## HABmin
RUN curl -fsL https://github.com/cdjackson/HABmin/releases/download/0.1.3-snapshot/habmin.zip | bsdtar xf - -C /opt/openhab/ && \
    rm -f /opt/openhab/addons/org.openhab.binding.zwave-1.5.0-SNAPSHOT.jar


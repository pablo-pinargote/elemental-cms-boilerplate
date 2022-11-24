FROM python:3.7-buster

RUN apt-get install bash
RUN mkdir -p /usr/default/src

WORKDIR /usr/app/src

COPY requirements.txt /usr/app/src
RUN pip install --no-cache-dir -r requirements.txt

#RUN pip install --trusted-host paranoid-software.asuscomm.com -i http://paranoid-software.asuscomm.com:7201 paranoid_logy -U
#RUN pip install --trusted-host paranoid-software.asuscomm.com -i http://paranoid-software.asuscomm.com:7201 paranoid_zookeeper -U

RUN ln -sf /dev/stdout /var/log/access.log && \
    ln -sf /dev/stderr /var/log/error.log

ADD . /usr/app/src

ENV PYTHONPATH "${PYTHONPATH}:/usr/app"

CMD ["bash", "run.sh"]
#CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

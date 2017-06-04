FROM erikschlegel/spark-base:2.1.0
ADD start-master-ha /
ENTRYPOINT ["/bin/bash", "-c", "./start-master-ha"]

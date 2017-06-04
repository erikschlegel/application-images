all: spark zeppelin
push: push-spark push-zeppelin
.PHONY: push push-spark push-zeppelin spark zeppelin zeppelin-build

# To bump the Spark version, bump the spark_ver in Dockerfile, bump
# this tag and reset to v1. You should also double check the native
# Hadoop libs at that point (we grab the 2.6.1 libs, which are
# appropriate for 1.5.2-with-2.6). Note that you'll need to re-test
# Zeppelin (and it may not have caught up to newest Spark).
SPARK_TAG = 2.2.0-ha
ZEPPELIN_TAG = 0.7

# To bump the Zeppelin version, bump the version in
# zeppelin/Dockerfile and bump this tag and reset to v1.

spark-base:
	docker build -t erikschlegel/spark-base . -f Dockerfile.base
	docker tag erikschlegel/spark-base erikschlegel/spark-base:$(SPARK_TAG)

spark-master: spark-base
	docker build -t erikschlegel/spark-master . -f Dockerfile.master
	docker tag erikschlegel/spark-master erikschlegel/spark-master:$(SPARK_TAG)

spark-worker: spark-base
	docker build -t erikschlegel/spark-worker . -f Dockerfile.worker
	docker tag erikschlegel/spark-worker erikschlegel/spark-worker:$(SPARK_TAG)

spark-master-ha: spark-base
	docker build -t erikschlegel/spark-master-ha . -f Dockerfile.master.ha
	docker tag erikschlegel/spark-master-ha erikschlegel/spark-master-ha:$(SPARK_TAG)

spark: spark-base spark-master spark-master-ha spark-worker

# This target is useful when needing to use an unreleased version of Zeppelin
zeppelin-build:
	docker build -t erikschlegel/zeppelin-build zeppelin-build
	docker tag erikschlegel/zeppelin-build erikschlegel/zeppelin-build:$(ZEPPELIN_TAG)

zeppelin:
	docker build -t erikschlegel/zeppelin zeppelin
	docker tag erikschlegel/zeppelin erikschlegel/zeppelin:$(ZEPPELIN_TAG)

push-spark-base: spark-base
	docker push erikschlegel/spark-base
	docker push erikschlegel/spark-base:$(SPARK_TAG)

push-spark-master: spark-master
	docker push erikschlegel/spark-master
	docker push erikschlegel/spark-master:$(SPARK_TAG)

push-spark-master-ha: spark-master-ha
	docker push erikschlegel/spark-master-ha
	docker push erikschlegel/spark-master-ha:$(SPARK_TAG)

push-spark-worker: spark-worker
	docker push erikschlegel/spark-worker
	docker push erikschlegel/spark-worker:$(SPARK_TAG)

push-spark: push-spark-base push-spark-master push-spark-master-ha push-spark-worker

push-zeppelin: zeppelin
	docker push erikschlegel/zeppelin
	docker push erikschlegel/zeppelin:$(ZEPPELIN_TAG)

clean:
	docker rm -f $$(docker ps -aq) > /dev/null 2>&1 ;true
	docker rmi -f $$(docker images -a | grep "^erikschlegel/zeppelin" | awk '{print $3}') > /dev/null 2>&1 ;true
	docker rmi -f $$(docker images -a | grep "^erikschlegel/spark-master" | awk '{print $3}') > /dev/null 2>&1 ;true
	docker rmi -f $$(docker images -a | grep "^erikschlegel/spark-master-ha" | awk '{print $3}') > /dev/null 2>&1 ;true
	docker rmi -f $$(docker images -a | grep "^erikschlegel/spark-worker" | awk '{print $3}') > /dev/null 2>&1 ;true
	docker rmi -f $$(docker images -a | grep "^erikschlegel/spark-base" | awk '{print $3}') > /dev/null 2>&1 ;true
	docker rmi -f $$(docker images -a | grep "^<none>" | awk '{print $3}') > /dev/null 2>&1 ;true

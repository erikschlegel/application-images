all: spark zeppelin
push: push-spark push-zeppelin
.PHONY: push push-spark push-zeppelin spark zeppelin zeppelin-build

# To bump the Spark version, bump the spark_ver in Dockerfile, bump
# this tag and reset to v1. You should also double check the native
# Hadoop libs at that point (we grab the 2.6.1 libs, which are
# appropriate for 1.5.2-with-2.6). Note that you'll need to re-test
# Zeppelin (and it may not have caught up to newest Spark).
SPARK_TAG = 2.1.0
ZEPPELIN_TAG = 0.6.2

# To bump the Zeppelin version, bump the version in
# zeppelin/Dockerfile and bump this tag and reset to v1.

spark-base:
	docker build -t srfrnk/spark-base . -f Dockerfile.base
	docker tag srfrnk/spark-base srfrnk/spark-base:$(SPARK_TAG)

spark-master: spark-base
	docker build -t srfrnk/spark-master . -f Dockerfile.master
	docker tag srfrnk/spark-master srfrnk/spark-master:$(SPARK_TAG)

spark-worker: spark-base
	docker build -t srfrnk/spark-worker . -f Dockerfile.worker
	docker tag srfrnk/spark-worker srfrnk/spark-worker:$(SPARK_TAG)

spark: spark-base spark-master spark-worker

# This target is useful when needing to use an unreleased version of Zeppelin
zeppelin-build:
	docker build -t srfrnk/zeppelin-build zeppelin-build
	docker tag srfrnk/zeppelin-build srfrnk/zeppelin-build:$(ZEPPELIN_TAG)

zeppelin:
	docker build -t srfrnk/zeppelin zeppelin
	docker tag srfrnk/zeppelin srfrnk/zeppelin:$(ZEPPELIN_TAG)

push-spark-base: spark-base
	docker push srfrnk/spark-base
	docker push srfrnk/spark-base:$(SPARK_TAG)

push-spark-master: spark-master
	docker push srfrnk/spark-master
	docker push srfrnk/spark-master:$(SPARK_TAG)

push-spark-worker: spark-worker
	docker push srfrnk/spark-worker
	docker push srfrnk/spark-worker:$(SPARK_TAG)

push-spark: push-spark-base push-spark-master push-spark-worker

push-zeppelin: zeppelin
	docker push srfrnk/zeppelin
	docker push srfrnk/zeppelin:$(ZEPPELIN_TAG)

clean:
	docker rm -f $$(docker ps -aq) > /dev/null 2>&1 ;true
	docker rmi -f $$(docker images -a | grep "^srfrnk/zeppelin" | awk '{print $3}') > /dev/null 2>&1 ;true
	docker rmi -f $$(docker images -a | grep "^srfrnk/spark-master" | awk '{print $3}') > /dev/null 2>&1 ;true
	docker rmi -f $$(docker images -a | grep "^srfrnk/spark-worker" | awk '{print $3}') > /dev/null 2>&1 ;true
	docker rmi -f $$(docker images -a | grep "^srfrnk/spark-base" | awk '{print $3}') > /dev/null 2>&1 ;true
	docker rmi -f $$(docker images -a | grep "^<none>" | awk '{print $3}') > /dev/null 2>&1 ;true

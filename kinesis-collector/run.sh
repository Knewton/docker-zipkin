#!/bin/bash

#add for remote debugging, don't forget to expose 5005 in the Dockerfile
# -J-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005\

scala \
    -classpath "/tdist-zipkin-collector.jar" com.knewton.tdist.zipkin.receiver.kinesis.KinesisReceiverApp\
    -zipkin.storage.redis.host==$DB_HOST\
    -zipkin.storage.redis.ttl=168\
    -kinesis.application.name=ZipkinCollector1\
    -kinesis.stream.name=$ENVIRONMENT_NAME-zipkin\
    -aws.access.key=$ACCESS_KEY\
    -aws.secret.key=$SECRET_KEY\
    -com.twitter.finagle.zipkin.initialSampleRate=1.0\
    -log.level=INFO\
    -admin.port=":9903"

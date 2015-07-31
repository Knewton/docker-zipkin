#!/bin/bash
cd zipkin

SERVICE_NAME="zipkin-query-service"
CONFIG="${SERVICE_NAME}/config/query-redis.scala"

cat << EOF > $CONFIG
import com.twitter.util.Duration
import com.twitter.zipkin.builder.QueryServiceBuilder
import com.twitter.zipkin.redis
import com.twitter.zipkin.storage.Store

// development mode.

val host = "$DB_HOST"
val port = 6379
val ttl: Duration = Duration.fromSeconds(604800)

val storeBuilder = Store.Builder(
  redis.StorageBuilder(host, port, ttl),
  redis.IndexBuilder(host, port, ttl))

QueryServiceBuilder(storeBuilder)
EOF

echo "** Starting ${SERVICE_NAME}..."
./gradlew :zipkin-query-service:run -PconfigKey=redis

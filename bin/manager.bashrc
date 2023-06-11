function kafka-acls() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-acls $@"
}

function kafka-broker-api-versions() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-broker-api-versions $@"
}

function kafka-cluster() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-cluster $@"
}

function kafka-configs() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-configs $@"
}

function kafka-console-consumer() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-console-consumer $@"
}

function kafka-console-producer() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-console-producer $@"
}

function kafka-consumer-groups() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-consumer-groups $@"
}

function kafka-consumer-perf-test() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-consumer-perf-test $@"
}

function kafka-delegation-tokens() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-delegation-tokens $@"
}

function kafka-delete-records() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-delete-records $@"
}

function kafka-dump-log() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-dump-log $@"
}

function kafka-features() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-features $@"
}

function kafka-get-offsets() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-get-offsets $@"
}

function kafka-leader-election() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-leader-election $@"
}

function kafka-log-dirs() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-log-dirs $@"
}

function kafka-metadata-quorum() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-metadata-quorum $@"
}

function kafka-metadata-shell() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-metadata-shell $@"
}

function kafka-mirror-maker() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-mirror-maker $@"
}

function kafka-preferred-replica-election() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-preferred-replica-election $@"
}

function kafka-producer-perf-test() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-producer-perf-test $@"
}

function kafka-reassign-partitions() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-reassign-partitions $@"
}

function kafka-replica-verification() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-replica-verification $@"
}

function kafka-run-class() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-run-class $@"
}

function kafka-server-start() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-server-start $@"
}

function kafka-server-stop() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-server-stop $@"
}

function kafka-storage() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-storage $@"
}

function kafka-streams-application-reset() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-streams-application-reset $@"
}

function kafka-topics() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-topics $@"
}

function kafka-transactions() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-transactions $@"
}

function kafka-verifiable-consumer() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-verifiable-consumer $@"
}

function kafka-verifiable-producer() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-verifiable-producer $@"
}

function zookeeper-security-migration() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/zookeeper-security-migration $@"
}

function zookeeper-server-start() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/zookeeper-server-start $@"
}

function zookeeper-server-stop() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/zookeeper-server-stop $@"
}

function zookeeper-shell() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/zookeeper-shell $@"
}

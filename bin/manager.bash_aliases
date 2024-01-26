function docker() {
    ssh -o ConnectTimeout=10 root@"${DIND_HOST:-dind}" "docker $@"
}

function execute() {
    docker compose exec -T "${HOST:-${DIND_HOST:-dind}}" "$@"
}

function new_file() {
    local file_path=$1
    [ -z "${file_path}" ] && {
        echo "A new file's path expected" >&2
        return 1
    }

    cat - | execute cp /dev/stdin "${file_path}"
}

function kafka-console-consumer() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-console-consumer" "$@"
}

function kafka-console-producer() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-console-producer" "$@"
}

function kafka-acls() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-acls" "$@"
}

function kafka-broker-api-versions() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-broker-api-versions" "$@"
}

function kafka-cluster() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-cluster" "$@"
}

function kafka-configs() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-configs" "$@"
}

function kafka-console-consumer() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-console-consumer" "$@"
}

function kafka-console-producer() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-console-producer" "$@"
}

function kafka-consumer-groups() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-consumer-groups" "$@"
}

function kafka-consumer-perf-test() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-consumer-perf-test" "$@"
}

function kafka-delegation-tokens() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-delegation-tokens" "$@"
}

function kafka-delete-records() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-delete-records" "$@"
}

function kafka-dump-log() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-dump-log" "$@"
}

function kafka-features() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-features" "$@"
}

function kafka-get-offsets() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-get-offsets" "$@"
}

function kafka-leader-election() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-leader-election" "$@"
}

function kafka-log-dirs() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-log-dirs" "$@"
}

function kafka-metadata-quorum() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-metadata-quorum" "$@"
}

function kafka-metadata-shell() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-metadata-shell" "$@"
}

function kafka-mirror-maker() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-mirror-maker" "$@"
}

function kafka-preferred-replica-election() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-preferred-replica-election" "$@"
}

function kafka-producer-perf-test() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-producer-perf-test" "$@"
}

function kafka-reassign-partitions() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-reassign-partitions" "$@"
}

function kafka-replica-verification() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-replica-verification" "$@"
}

function kafka-run-class() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-run-class" "$@"
}

function kafka-server-start() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-server-start" "$@"
}

function kafka-server-stop() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-server-stop" "$@"
}

function kafka-storage() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-storage" "$@"
}

function kafka-streams-application-reset() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-streams-application-reset" "$@"
}

function kafka-topics() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-topics" "$@"
}

function kafka-transactions() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-transactions" "$@"
}

function kafka-verifiable-consumer() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-verifiable-consumer" "$@"
}

function kafka-verifiable-producer() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/kafka-verifiable-producer" "$@"
}

function zookeeper-security-migration() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/zookeeper-security-migration" "$@"
}

function zookeeper-server-start() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/zookeeper-server-start" "$@"
}

function zookeeper-server-stop() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/zookeeper-server-stop" "$@"
}

function zookeeper-shell() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/zookeeper-shell" "$@"
}

function connect-mirror-maker() {
    HOST=${KAFKA_HOST:-kafka} execute "/usr/bin/connect-mirror-maker" "$@"
}

function ksql(){
    [ -z "$KSQL_CLI_HOST" ] && {
        echo "No KSQL_CLI_HOST environment variable defined" >&2
        return 1
    }

    HOST=${KSQL_CLI_HOST} execute "/usr/bin/ksql" "$@"
}

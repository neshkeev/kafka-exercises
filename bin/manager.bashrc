function sshcat() {
    local file_name=${1:-&1}
    local host_name=${2:-"$KAFKA_HOST"}

    [ "$file_name" == "-" ] && local file_name='&1'

    ssh "${SSH_USER:-appuser}"@"${host_name}" -p 2222 "cat - >${file_name}"
}

function ssheval() {
    ssh appuser@"$KAFKA_HOST" -p 2222 "$@"
}

function kafka-acls() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-acls $@
}

function kafka-broker-api-versions() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-broker-api-versions $@
}

function kafka-cluster() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-cluster $@
}

function kafka-configs() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-configs $@
}

function kafka-console-consumer() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-console-consumer $@
}

function kafka-console-producer() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-console-producer $@
}

function kafka-consumer-groups() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-consumer-groups $@
}

function kafka-consumer-perf-test() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-consumer-perf-test $@
}

function kafka-delegation-tokens() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-delegation-tokens $@
}

function kafka-delete-records() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-delete-records $@
}

function kafka-dump-log() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-dump-log $@
}

function kafka-features() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-features $@
}

function kafka-get-offsets() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-get-offsets $@
}

function kafka-leader-election() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-leader-election $@
}

function kafka-log-dirs() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-log-dirs $@
}

function kafka-metadata-quorum() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-metadata-quorum $@
}

function kafka-metadata-shell() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-metadata-shell $@
}

function kafka-mirror-maker() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-mirror-maker $@
}

function kafka-preferred-replica-election() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-preferred-replica-election $@
}

function kafka-producer-perf-test() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-producer-perf-test $@
}

function kafka-reassign-partitions() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-reassign-partitions $@
}

function kafka-replica-verification() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-replica-verification $@
}

function kafka-run-class() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-run-class $@
}

function kafka-server-start() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-server-start $@
}

function kafka-server-stop() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-server-stop $@
}

function kafka-storage() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-storage $@
}

function kafka-streams-application-reset() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-streams-application-reset $@
}

function kafka-topics() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-topics $@
}

function kafka-transactions() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-transactions $@
}

function kafka-verifiable-consumer() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-verifiable-consumer $@
}

function kafka-verifiable-producer() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/kafka-verifiable-producer $@
}

function zookeeper-security-migration() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/zookeeper-security-migration $@
}

function zookeeper-server-start() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/zookeeper-server-start $@
}

function zookeeper-server-stop() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/zookeeper-server-stop $@
}

function zookeeper-shell() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/zookeeper-shell $@
}

function ksql(){
    [ -z "$KSQL_CLI_HOST" ] && {
        echo "No KSQL_CLI_HOST environment variable defined" >&2
        return 1
    }
    ssh -o ConnectTimeout=10 appuser@"$KSQL_CLI_HOST" -p 2222 "/usr/bin/ksql $@"
}

function connect-mirror-maker() {
    docker compose exec -T "$KAFKA_HOST" /usr/bin/connect-mirror-maker $@
}

function docker() {
    ssh -o ConnectTimeout=10 root@"$DIND_HOST" -p 2222 "cd /root/\$(cat /tmp/cwd); /usr/local/bin/docker $@"
}

function confluent-hub() {
    docker compose exec -it connect /usr/bin/confluent-hub $@
}

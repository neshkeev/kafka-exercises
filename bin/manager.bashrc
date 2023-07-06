function sshcat() {
    local file_name=${1:-&1}
    local host_name=${2:-"$KAFKA_HOST"}

    [ "$file_name" == "-" ] && local file_name='&1'

    ssh appuser@"${host_name}" -p 2222 "cat - >${file_name}"
}

function ssheval() {
    ssh appuser@"$KAFKA_HOST" -p 2222 "$@"
}

function kafka-acls() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-acls $@"
}

function kafka-broker-api-versions() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-broker-api-versions $@"
}

function kafka-cluster() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-cluster $@"
}

function kafka-configs() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-configs $@"
}

function kafka-console-consumer() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-console-consumer $@"
}

function kafka-console-producer() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-console-producer $@"
}

function kafka-consumer-groups() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-consumer-groups $@"
}

function kafka-consumer-perf-test() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-consumer-perf-test $@"
}

function kafka-delegation-tokens() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-delegation-tokens $@"
}

function kafka-delete-records() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-delete-records $@"
}

function kafka-dump-log() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-dump-log $@"
}

function kafka-features() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-features $@"
}

function kafka-get-offsets() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-get-offsets $@"
}

function kafka-leader-election() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-leader-election $@"
}

function kafka-log-dirs() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-log-dirs $@"
}

function kafka-metadata-quorum() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-metadata-quorum $@"
}

function kafka-metadata-shell() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-metadata-shell $@"
}

function kafka-mirror-maker() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-mirror-maker $@"
}

function kafka-preferred-replica-election() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-preferred-replica-election $@"
}

function kafka-producer-perf-test() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-producer-perf-test $@"
}

function kafka-reassign-partitions() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-reassign-partitions $@"
}

function kafka-replica-verification() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-replica-verification $@"
}

function kafka-run-class() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-run-class $@"
}

function kafka-server-start() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-server-start $@"
}

function kafka-server-stop() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-server-stop $@"
}

function kafka-storage() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-storage $@"
}

function kafka-streams-application-reset() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-streams-application-reset $@"
}

function kafka-topics() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-topics $@"
}

function kafka-transactions() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-transactions $@"
}

function kafka-verifiable-consumer() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-verifiable-consumer $@"
}

function kafka-verifiable-producer() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/kafka-verifiable-producer $@"
}

function zookeeper-security-migration() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/zookeeper-security-migration $@"
}

function zookeeper-server-start() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/zookeeper-server-start $@"
}

function zookeeper-server-stop() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/zookeeper-server-stop $@"
}

function zookeeper-shell() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/zookeeper-shell $@"
}

function ksql(){
    [ -z "$KSQL_CLI_HOST" ] && {
        echo "No KSQL_CLI_HOST environment variable defined" >&2
        return 1
    }
    ssh -o ConnectTimeout=10 appuser@"$KSQL_CLI_HOST" -p 2222 "/usr/bin/ksql $@"
}

function connect-mirror-maker() {
    ssh -o ConnectTimeout=10 appuser@"$KAFKA_HOST" -p 2222 "/usr/bin/connect-mirror-maker $@"
}

function docker() {
    ssh -o ConnectTimeout=10 root@"$DIND_HOST" -p 2222 "cd /root/\$(cat /tmp/cwd); /usr/local/bin/docker $@"
}

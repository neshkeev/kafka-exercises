function kafka-topics() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-topics $@"
}

function kafka-console-producer() {
    ssh appuser@"${KAFKA_BROKERS}" -p 2222 "/usr/bin/kafka-console-producer $@"
}

function kafka-console-consumer() {
    ssh appuser@"$KAFKA_BROKERS" -p 2222 "/usr/bin/kafka-console-consumer $@"
}

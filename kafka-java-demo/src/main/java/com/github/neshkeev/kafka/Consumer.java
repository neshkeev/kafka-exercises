package com.github.neshkeev.kafka;

import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.serialization.IntegerDeserializer;
import org.apache.kafka.common.serialization.StringDeserializer;

import java.time.Duration;
import java.util.List;
import java.util.Properties;

public class Consumer {

    public static void main(String[] args) {
        final String bootstrap = args[0];
        final String topic = args[1];

        final var props = new Properties();
        props.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrap);
        props.put(ConsumerConfig.GROUP_ID_CONFIG, Consumer.class.getName());
        props.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, "true");
        props.put(ConsumerConfig.AUTO_COMMIT_INTERVAL_MS_CONFIG, "1000");
        props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");

        try (KafkaConsumer<Integer, String> consumer = new KafkaConsumer<>(props, new IntegerDeserializer(), new StringDeserializer())) {
            consumer.subscribe(List.of(topic));

            final var start = System.currentTimeMillis();
            while (start + 60_000 > System.currentTimeMillis()) {
                var records = consumer.poll(Duration.ofSeconds(10));
                for (var record : records) {
                    System.out.printf("Topic: %s;partition: %d;key: %d;value:%s%n", record.topic(), record.partition(), record.key(), record.value());
                }
            }
        }
    }
}

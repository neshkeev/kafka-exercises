package com.github.neshkeev.kafka;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.IntegerSerializer;
import org.apache.kafka.common.serialization.StringSerializer;

import java.util.Properties;
import java.util.UUID;

public class Producer {
    public static void main(String[] args) throws InterruptedException {
        final String bootstrap = args[0];
        final String topic = args[1];

        final var props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrap);
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, IntegerSerializer.class);
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class);

        try (KafkaProducer<Integer, String> producer = new KafkaProducer<>(props)) {
            final var start = System.currentTimeMillis();
            while (start + 60_000 > System.currentTimeMillis()) {
                for (int i = 0; i < 10; i++) {
                    producer.send(new ProducerRecord<>(topic, i, UUID.randomUUID().toString()));
                }
                //noinspection BusyWait
                Thread.sleep(5_000);
            }
        }
    }
}

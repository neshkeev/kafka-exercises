package com.github.neshkeev.kafka.streams;

import com.github.neshkeev.kafka.avro.PlayEvent;
import io.confluent.kafka.serializers.AbstractKafkaSchemaSerDeConfig;
import io.confluent.kafka.serializers.KafkaAvroDeserializer;
import io.confluent.kafka.serializers.KafkaAvroDeserializerConfig;
import io.confluent.kafka.serializers.KafkaAvroSerializer;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.LongDeserializer;
import org.apache.kafka.common.serialization.LongSerializer;

import java.time.Duration;
import java.util.List;
import java.util.Properties;

public class NaiveTransformations {

    private static final String PLAY_EVENTS_TOPIC = "play-events";
    private static final String PLAY_EVENTS_ACTUAL_TOPIC = "play-events-actual-naive";
    private static final String PLAY_EVENTS_ACCIDENTAL_TOPIC = "play-events-accidental-naive";

    public static void main(String[] args) {
        final var schemaRegistryUrl = System.getenv("KAFKA_SCHEMA_REGISTRY");
        final var bootstrapServers = System.getenv("KAFKA_BOOTSTRAP_SERVERS");

        final Properties producerProperties = getProducerProperties(schemaRegistryUrl, bootstrapServers);
        final Properties consumerProperties = getConsumerProperties(schemaRegistryUrl, bootstrapServers);

        try (
                var producer = new KafkaProducer<Long, PlayEvent>(producerProperties);
                var consumer = new KafkaConsumer<Long, PlayEvent>(consumerProperties)
        ) {
            consumer.subscribe(List.of(PLAY_EVENTS_TOPIC));

            final var start = System.currentTimeMillis();
            while (start + 60_000 > System.currentTimeMillis()) {
                final ConsumerRecords<Long, PlayEvent> records = consumer.poll(Duration.ofSeconds(10));

                for (ConsumerRecord<Long, PlayEvent> record : records) {
                    final String topic = record.value().getDuration() > 20
                            ? PLAY_EVENTS_ACTUAL_TOPIC
                            : PLAY_EVENTS_ACCIDENTAL_TOPIC;
                    producer.send(new ProducerRecord<>(topic, record.key(), record.value()));
                }
            }
        }
    }

    private static Properties getConsumerProperties(String schemaRegistryUrl, String bootstrapServers) {
        final var consumerProperties = new Properties();
        consumerProperties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        consumerProperties.put(ConsumerConfig.GROUP_ID_CONFIG, NaiveTransformations.class.getName());
        consumerProperties.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, "true");
        consumerProperties.put(ConsumerConfig.AUTO_COMMIT_INTERVAL_MS_CONFIG, "1000");
        consumerProperties.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        consumerProperties.put(AbstractKafkaSchemaSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, schemaRegistryUrl);
        consumerProperties.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, LongDeserializer.class);
        consumerProperties.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, KafkaAvroDeserializer.class);
        consumerProperties.put(KafkaAvroDeserializerConfig.SPECIFIC_AVRO_READER_CONFIG, "true");
        return consumerProperties;
    }

    private static Properties getProducerProperties(String schemaRegistryUrl, String bootstrapServers) {
        final var producerProperties = new Properties();

        producerProperties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        producerProperties.put(AbstractKafkaSchemaSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, schemaRegistryUrl);
        producerProperties.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, LongSerializer.class);
        producerProperties.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, KafkaAvroSerializer.class);
        return producerProperties;
    }
}

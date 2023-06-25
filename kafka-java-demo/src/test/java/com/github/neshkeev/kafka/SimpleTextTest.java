package com.github.neshkeev.kafka;

import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.apache.kafka.common.serialization.StringSerializer;
import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import java.time.Duration;
import java.util.List;
import java.util.Properties;
import java.util.stream.Stream;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class SimpleTextTest {

    private static final String TOPIC = "my-text-based-consumer-topic";

    private static KafkaProducer<String, String> producer;
    private static KafkaConsumer<String, String> consumer;

    @Order(1)
    @ParameterizedTest
    @MethodSource("arguments")
    public void test(String key, String value) {
        producer.send(new ProducerRecord<>(TOPIC, key, value));
    }

    @Order(2)
    @Test
    public void test() {
        final var start = System.currentTimeMillis();
        while (start + 10_000 > System.currentTimeMillis()) {
            var records = consumer.poll(Duration.ofSeconds(10));
            for (var record : records) {
                System.out.println("key: \t" + record.key() + ", Value: \t" + record.value());
            }
        }
    }

    public static Stream<Arguments> arguments() {
        return Stream.of(
                Arguments.of("John", "John Snow"),
                Arguments.of("John", "John Doe"),
                Arguments.of("Jane", "Jane Doe"),
                Arguments.of("Jack", "Jack Smith")
        );
    }

    @BeforeAll
    public static void before() {
        prepareProducer();
        prepareConsumer();
    }

    private static void prepareProducer() {
        final var props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, getKafkaBootstrapServer());
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class);

        producer = new KafkaProducer<>(props);
    }

    private static void prepareConsumer() {
        final var props = new Properties();
        props.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, getKafkaBootstrapServer());
        props.put(ConsumerConfig.GROUP_ID_CONFIG, SimpleTextTest.class.getName());
        props.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, "true");
        props.put(ConsumerConfig.AUTO_COMMIT_INTERVAL_MS_CONFIG, "1000");
        props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        consumer = new KafkaConsumer<>(props, new StringDeserializer(), new StringDeserializer());
        consumer.subscribe(List.of(TOPIC));
    }

    private static String getKafkaBootstrapServer() {
        String kafkaBootstrapServer = System.getenv("KAFKA_BOOTSTRAP_SERVER");
        if (kafkaBootstrapServer == null || kafkaBootstrapServer.isBlank()) {
            return "localhost:19092";
        }
        return kafkaBootstrapServer;
    }

    @AfterAll
    public static void after() {
        producer.close();
        consumer.close(Duration.ofSeconds(5));
    }
}

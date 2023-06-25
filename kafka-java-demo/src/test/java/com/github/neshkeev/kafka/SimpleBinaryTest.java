package com.github.neshkeev.kafka;

import com.github.neshkeev.kafka.customer.CustomerKey;
import com.github.neshkeev.kafka.customer.avro.Customer;
import io.confluent.kafka.serializers.AbstractKafkaSchemaSerDeConfig;
import io.confluent.kafka.serializers.KafkaAvroDeserializer;
import io.confluent.kafka.serializers.KafkaAvroSerializer;
import io.confluent.kafka.serializers.protobuf.KafkaProtobufDeserializer;
import io.confluent.kafka.serializers.protobuf.KafkaProtobufSerializer;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import java.time.Duration;
import java.util.List;
import java.util.Properties;
import java.util.UUID;
import java.util.stream.Stream;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class SimpleBinaryTest {

    private static final String TOPIC = "my-binary-consumer-topic";

    private static KafkaProducer<CustomerKey.Key, Customer> producer;
    private static KafkaConsumer<CustomerKey.Key, Customer> consumer;

    @Order(1)
    @ParameterizedTest
    @MethodSource("arguments")
    public void test(CustomerKey.Key key, Customer value) {
        producer.send(new ProducerRecord<>(TOPIC, key, value));
    }

    @Order(2)
    @Test
    public void test() {
        final var start = System.currentTimeMillis();
        while (start + 10_000 > System.currentTimeMillis()) {
            var records = consumer.poll(Duration.ofSeconds(10));
            for (var record : records) {
                System.out.println("key: \t" + record.key().getId());
                final var value = record.value();
                System.out.println("id: \t" + value.getId() + ", name: \t" + value.getName());
                System.out.println("================");
            }
        }
    }

    public static Stream<Arguments> arguments() {
        return Stream.of(
                Arguments.of(
                        CustomerKey.Key.newBuilder()
                                .setId(UUID.randomUUID().toString())
                                .build(),
                        Customer.newBuilder()
                                .setId("John")
                                .setName("John Doe")
                                .build()
                ),
                Arguments.of(
                        CustomerKey.Key.newBuilder()
                                .setId(UUID.randomUUID().toString())
                                .build(),
                        Customer.newBuilder()
                                .setId("Jack")
                                .setName("Jack Sparrow")
                                .build()
                ),
                Arguments.of(
                        CustomerKey.Key.newBuilder()
                                .setId(UUID.randomUUID().toString())
                                .build(),
                        Customer.newBuilder()
                                .setId("Jane")
                                .setName("Jane Doe")
                                .build()
                )
        );
    }

    @BeforeAll
    public static void before() {
        prepareProducer();
        prepareConsumer();
    }

    private static void prepareProducer() {
        final var props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, getBoostrapServers());
        props.put(AbstractKafkaSchemaSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, System.getenv("KAFKA_SCHEMA_REGISTRY"));
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, KafkaProtobufSerializer.class);
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, KafkaAvroSerializer.class);

        producer = new KafkaProducer<>(props);
    }

    private static String getBoostrapServers() {
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

    public static void prepareConsumer() {
        final var props = new Properties();
        props.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, getBoostrapServers());
        props.put(ConsumerConfig.GROUP_ID_CONFIG, SimpleBinaryTest.class.getName());
        props.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, "true");
        props.put(ConsumerConfig.AUTO_COMMIT_INTERVAL_MS_CONFIG, "1000");
        props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        props.put(AbstractKafkaSchemaSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, System.getenv("KAFKA_SCHEMA_REGISTRY"));
        props.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, KafkaProtobufDeserializer.class);
        props.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, KafkaAvroDeserializer.class);
        consumer = new KafkaConsumer<>(props);
        consumer.subscribe(List.of(TOPIC));
    }
}

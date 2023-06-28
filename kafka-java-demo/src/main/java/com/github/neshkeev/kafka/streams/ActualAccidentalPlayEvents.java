package com.github.neshkeev.kafka.streams;

import com.github.neshkeev.kafka.avro.PlayEvent;
import io.confluent.kafka.serializers.AbstractKafkaSchemaSerDeConfig;
import io.confluent.kafka.streams.serdes.avro.SpecificAvroSerde;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KafkaStreams;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.Topology;
import org.apache.kafka.streams.kstream.KStream;

import java.time.Duration;
import java.util.Properties;
import java.util.concurrent.CountDownLatch;

public class ActualAccidentalPlayEvents {
    private static final String PLAY_EVENTS_TOPIC = "play-events";
    private static final String PLAY_EVENTS_ACTUAL_TOPIC = "play-events-actual";
    private static final String PLAY_EVENTS_ACCIDENTAL_TOPIC = "play-events-accidental";

    public static void main(String[] args) throws InterruptedException {
        final var delay = args.length > 0
                ? Integer.parseInt(args[0])
                : 60;

        final Properties configs = getStreamsConfigs();

        final var streamsBuilder = new StreamsBuilder();
        final var topology = getStreamsTopology(streamsBuilder);
        System.out.println(topology.describe());

        final KafkaStreams streams = new KafkaStreams(topology, configs);

        var latch = delay(Duration.ofSeconds(delay));

        streams.cleanUp();
        streams.start();

        Runtime.getRuntime().addShutdownHook(new Thread(streams::close));
        latch.await();

        System.out.println("Stopping streams...");
        streams.close(Duration.ofSeconds(10));
        System.out.println("Streams have been stopped");
    }

    private static CountDownLatch delay(Duration delay) {
        final CountDownLatch latch = new CountDownLatch(1);
        new Thread(() -> {
            try {
                Thread.sleep(delay.toMillis());
                latch.countDown();
            }
            catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }).start();
        return latch;
    }

    private static Topology getStreamsTopology(StreamsBuilder builder) {

        final KStream<Long, PlayEvent> playEvents = builder.stream(PLAY_EVENTS_TOPIC);
        final KStream<Long, PlayEvent> actual = playEvents.filter((k, v) -> v.getDuration() > 20);
        final KStream<Long, PlayEvent> accidental = playEvents.filter((k, v) -> v.getDuration() <= 20);

        actual.to(PLAY_EVENTS_ACTUAL_TOPIC);
        accidental.to(PLAY_EVENTS_ACCIDENTAL_TOPIC);

        return builder.build();
    }

    private static Properties getStreamsConfigs() {
        final var schemaRegistryUrl = System.getenv("KAFKA_SCHEMA_REGISTRY");
        final var bootstrapServers = System.getenv("KAFKA_BOOTSTRAP_SERVERS");

        final Properties streamsConfiguration = new Properties();

        streamsConfiguration.put(StreamsConfig.APPLICATION_ID_CONFIG, "my-stream-demo-app");
        streamsConfiguration.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);

        streamsConfiguration.put(StreamsConfig.STATE_DIR_CONFIG, "/tmp/streams/");
        streamsConfiguration.put(AbstractKafkaSchemaSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, schemaRegistryUrl);

        streamsConfiguration.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.LongSerde.class);
        streamsConfiguration.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, SpecificAvroSerde.class);

        return streamsConfiguration;
    }
}

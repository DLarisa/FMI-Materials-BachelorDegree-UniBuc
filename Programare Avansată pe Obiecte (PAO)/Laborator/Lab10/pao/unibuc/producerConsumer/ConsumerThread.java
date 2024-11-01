package pao.unibuc.producerConsumer;

import java.util.function.Consumer;

public class ConsumerThread<T> extends Thread {
    private Storage<T> storage;
    private Consumer<T> consumer;
    public ConsumerThread(Storage<T> storage, Consumer<T> consumer) {
        this.storage = storage;
        this.consumer = consumer;
    }

    @Override
    public void run() {
        while (true) {
            try {
                consumer.accept(storage.get());
                sleep((long) (1000 * Math.random()));
            } catch (InterruptedException e) {
            }
        }
    }
}

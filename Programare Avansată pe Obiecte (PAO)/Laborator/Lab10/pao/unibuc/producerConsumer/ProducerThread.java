package pao.unibuc.producerConsumer;

import java.util.function.Supplier;

public class ProducerThread<T> extends Thread {
    private Storage<T> storage;
    private Supplier<T> supplier;

    public ProducerThread(Storage<T> storage, Supplier<T> supplier) {
        this.storage = storage;
        this.supplier = supplier;
    }
    @Override
    public void run() {
        while (true) {
            try {
                storage.put(supplier.get());
                sleep((long) (1000 * Math.random()));
            } catch (InterruptedException e) {
            }
        }
    }
}

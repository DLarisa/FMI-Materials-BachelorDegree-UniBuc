package pao.unibuc.producerConsumer;

public class Main {
    public static void main(String[] args) {
        try {
            Storage<String> storage = new Storage<String>(3);
            ProducerThread<String> producerThread = new ProducerThread<String>(storage, () -> "portocale");
            ConsumerThread<String> consumerThread = new ConsumerThread<String>(storage, item->{});
            producerThread.start();
            consumerThread.start();
            producerThread.join();
            consumerThread.join();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

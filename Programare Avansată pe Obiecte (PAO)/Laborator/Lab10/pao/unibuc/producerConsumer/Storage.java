package pao.unibuc.producerConsumer;

import java.util.LinkedList;
import java.util.Queue;

public class Storage<T> {

    private Queue<T> queue;
    private int capacity;

    public Storage(int capacity) {
        this.queue = new LinkedList<T>();
        this.capacity = capacity;
    }

    public synchronized T get() throws InterruptedException {
        while (queue.isEmpty()) {
            wait();
        }
        T item = queue.poll();
        notifyAll();
        System.out.println("dupa consumare sunt: " + queue.size());
        return item;
    }

    public synchronized void put(T item) throws InterruptedException {
        while (queue.size() == capacity) {
            wait();
        }
        queue.add(item);
        notifyAll();
        System.out.println("dupa adaugare sunt: " + queue.size());
    }
}

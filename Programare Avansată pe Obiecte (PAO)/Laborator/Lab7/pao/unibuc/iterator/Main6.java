package pao.unibuc.iterator;

import java.util.Iterator;

public class Main6 {
    public static void main(String[] args) {
        for(Iterator<Integer> iterator = new SieveOfEratosthenes(100); iterator.hasNext();) {
            System.out.println(iterator.next());
        }
    }
}

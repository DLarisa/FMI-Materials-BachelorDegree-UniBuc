package pao.unibuc.iterator;

import java.util.Iterator;

public class SieveOfEratosthenes implements Iterator<Integer> {
    private int limit;
    private int[] numbers;
    private int index;

    public SieveOfEratosthenes(int limit){
        this.limit = limit;
        this.numbers = new int [limit + 1];
        index = 2;
    }

    @Override
    public boolean hasNext() {
       return index <= limit;
    }

    @Override
    public Integer next() {
        int number = index;
        index++;

        for(int i = index; i <= limit; i++){
            if(i% number == 0){
                numbers[i] = 1;
            }
        }

        while(index <= limit && numbers[index] == 1){
            index++;
        }
        return number;
    }
}

package pao.unibuc.tree;

import java.util.Random;
import java.util.TreeSet;

public class Main3 {
    public static void main(String[] args) {
        TreeSet<Integer> numbers = new TreeSet<Integer>();
        Random random = new Random();
        int n = 100;
        for(int i = 0; i< n; i++){
            numbers.add(random.nextInt(n));
        }
        for(int number : numbers){
            System.out.println(number);
        }
    }
}

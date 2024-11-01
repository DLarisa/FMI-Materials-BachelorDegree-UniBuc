package pao.unibuc.clone;

import java.util.Arrays;
import java.util.Random;

public class Main {
    public static void main(String[] args) {
        int [] original = new Random().ints(3, 1, 10).toArray();
        int [] clone = Cloner.clone(original);
        for(int i =0; i< clone.length; i++){
            clone[i] +=10;
        }
        System.out.println("Original: ");
        Arrays.stream(original).forEach(System.out::println);
        System.out.println("Clone: ");
        Arrays.stream(clone).forEach(System.out::println);
    }
}

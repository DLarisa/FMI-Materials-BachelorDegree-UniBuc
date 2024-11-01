package pao.unibuc.arrayList;

public class Main1 {
    public static void main(String[] args) {
        for(int i = 1; i <= 20; i++){
            System.out.println(String.format("f (%d) = %d", i, FibonacciStream.get(i)));
        }
    }
}

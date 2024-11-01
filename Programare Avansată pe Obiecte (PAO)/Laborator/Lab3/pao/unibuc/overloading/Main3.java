package pao.unibuc.overloading;

public class Main3 {
    public static void main(String[] args) {
        MyClass myClass = new MyClass();

        myClass.sum(4, 5);
        myClass.sum(1, 4.5f);
        myClass.sum(5,11,2);
        myClass.sum(1.2f, 9);
    }
}

package pao.unibuc.constructors;

public class MyClass2 extends BaseClass2 {
    int a;
    float b;
    public MyClass2(){
        super(0);
        System.out.println("Class constructor call");
    }
    public MyClass2(int a, float b){
        super(0);
        this.a = a;
        this.b = b;
        System.out.println("Class constructor call with params");
    }
}

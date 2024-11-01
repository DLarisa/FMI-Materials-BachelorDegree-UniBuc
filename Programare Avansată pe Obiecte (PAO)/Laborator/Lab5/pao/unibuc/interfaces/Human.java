package pao.unibuc.interfaces;

public interface Human {
    String DEFAULT_NAME = "john doe";

    void run();
    void speak();

    default String getName(){
   //     myHiddenMethod();
        return DEFAULT_NAME;
    }

    private void myHiddenMethod(){
        System.out.println("private method");
    }


    default String test(){
     //   myHiddenMethod();
        return "testing human interface";
    }

    static boolean isAdult(int age){
        return age >= 18;
    }
}

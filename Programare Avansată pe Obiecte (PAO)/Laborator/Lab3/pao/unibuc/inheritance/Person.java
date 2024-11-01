package pao.unibuc.inheritance;

public class Person {
    protected String name;
    protected int age;

    private String nickname;

    public Person(String name, int age){
        this.name = name;
        this.age = age;
        System.out.println("I am a person");
        nickname = "test";
    }

    protected void listInfo(){
        System.out.println("Name: " + name + ", Age: " + age);
    }
    private void sayClassType(){
        System.out.println("I am a person");
    }

//    public void incrementSalary(int amount){
//        System.out.println("increment from person");
//    }

    public final void method1(){
        System.out.println("Say hi from final method");
    }
}

package pao.unibuc.interfaces;

public class Person implements Human {
    private String name;

    public Person(String name){
        this.name = name;
    }
    @Override
    public void run() {
        System.out.println("Person running..");
    }

    @Override
    public void speak() {
        System.out.println("Person speaking..");
    }

    @Override
    public String getName() {
        return name;
    }
}

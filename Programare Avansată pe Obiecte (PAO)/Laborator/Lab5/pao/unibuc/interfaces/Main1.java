package pao.unibuc.interfaces;

public class Main1 {
    public static void main(String[] args) {
        Person person = new Person("Ion Ionescu");
        person.run();
        person.speak();
        System.out.println(person.getName());

        Child child = new Child();
        child.run();
        child.speak();
        System.out.println(child.getName());
        System.out.println(child.test());

        System.out.println(Human.isAdult(30));
        System.out.println(Human.isAdult(15));
    }
}

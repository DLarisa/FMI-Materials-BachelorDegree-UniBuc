package pao.unibuc.inheritance;

public class Main2 {
    public static void main(String[] args) {
        Person p1 = new Person("Alex", 20);
        System.out.println("---------------");
        Employee e1 = new Employee("Ioana", 25, 1000);
        System.out.println("---------------");
        Developer d1 = new Developer("Paul", 27, 2000, "Java");

        System.out.println(d1.age);

        p1.listInfo();
        System.out.println("---------------");
        e1.listInfo();
        System.out.println("---------------");
        d1.listInfo();

        Person d2 = new Developer("Maria", 22, 3000, "JavaScript");
        d2.listInfo();
        System.out.println("---------------");
        Person e2 = new Employee("Ovidiu", 21, 1000);
        e2.listInfo();
    }
}

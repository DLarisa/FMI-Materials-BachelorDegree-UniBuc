package pao.unibuc.inheritance;

public class Employee extends Person {
    public double salary;

    public Employee(String name, int age, double salary){
        super(name, age);
        this.salary = salary;
        System.out.println("I am an employee");
      //  super.nickname = "abc";
    }

    @Override
    public void listInfo(){
      //  String name = "local name";
        super.listInfo();
        System.out.println("salary: " + salary);
    }

    public void showListInfoFromSuperClass(){
        super.listInfo();
    }

   // @Override
    private void sayClassType(){
        System.out.println("I am an employee");
    }

    public void incrementSalary(int amount){
        this.salary += amount;
        System.out.println("increment from employee");
    }
   // @Override
//    public void method1(){ //cannot override final methods
//        System.out.println("Say hi from final method");
//    }
}

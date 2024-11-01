package pao.unibuc.inheritance;

public class Developer extends Employee {
    public String language;

    public Developer(String name, int age, double salary, String language){
        super(name,age,salary);
        this.language = language;
        System.out.println("I am a developer");
    }
    @Override
    public void listInfo(){
        super.listInfo();
        System.out.println("language: " + language);
    }
}

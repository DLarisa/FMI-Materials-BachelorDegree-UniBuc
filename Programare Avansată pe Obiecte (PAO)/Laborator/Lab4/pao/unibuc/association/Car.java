package pao.unibuc.association;

public class Car {
    public String color;
    public Engine engine;

    public Car(String color, Engine engine){
        this.color = color;
        this.engine = new Engine(engine);
    }
}

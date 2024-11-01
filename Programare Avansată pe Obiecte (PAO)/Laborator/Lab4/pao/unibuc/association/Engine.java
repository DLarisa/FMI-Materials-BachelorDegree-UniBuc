package pao.unibuc.association;

public class Engine {
    public String type;
    public float capacity;

    public Engine(String type, float capacity){
        this.type = type;
        this.capacity = capacity;
    }
    public Engine (Engine engine){
        this.type = engine.type;
        this.capacity = engine.capacity;
    }
}

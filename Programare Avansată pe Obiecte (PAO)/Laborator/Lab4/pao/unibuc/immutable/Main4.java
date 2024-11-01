package pao.unibuc.immutable;

public class Main4 {
    public static void main(String[] args) {
        CarIdentification carIdentification = new CarIdentification("B122ABC");
        MyImmutableCar car = new MyImmutableCar(2016, carIdentification);
        CarIdentification identification = car.getCarIdenfication();
        System.out.println(carIdentification == identification);

        car.setCarIdentification(new CarIdentification("B89DFA"));
    }
}

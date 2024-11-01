package pao.unibuc.immutable;

import pao.unibuc.association.Car;

public final class MyImmutableCar {
    private final Integer year;
    private final CarIdentification carId;

    MyImmutableCar(Integer year, CarIdentification carId){
        this.year = year;
        this.carId = new CarIdentification(carId);
    }

    public CarIdentification getCarIdenfication(){
        return new CarIdentification(carId);
    }

    public void setCarIdentification(CarIdentification carIdentification){
        throw new UnsupportedOperationException("Operation is not allowed");
    }
}

class CarIdentification{
    private String licencePlate;
    public CarIdentification(String licencePlate){
        this.licencePlate = licencePlate;
    }
    public CarIdentification(CarIdentification carIdentification){
        this.licencePlate = carIdentification.licencePlate;
    }
}
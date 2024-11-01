package pao.unibuc.sorting;

import java.util.Objects;

public class Car implements Comparable {

    private int age;
    private String brand;
    private String type;

    public Car(int age, String brand, String type){
        this.brand = brand;
        this.age = age;
        this.type = type;
    }

    public String getType() {
        return type;
    }
    public int getAge() {
        return age;
    }
    public String getBrand() {
        return brand;
    }

    @Override
    public int compareTo(Object o) {
        Car car = (Car)o;
        return this.brand.compareTo(car.getBrand());
    }

    @Override
    public boolean equals(Object o) {
        return ((Car)o).getBrand().equals(this.brand);
    }

    @Override
    public String toString() {
        return "Car{" +
                "age=" + age +
                ", brand='" + brand + '\'' +
                ", type='" + type + '\'' +
                '}';
    }
}

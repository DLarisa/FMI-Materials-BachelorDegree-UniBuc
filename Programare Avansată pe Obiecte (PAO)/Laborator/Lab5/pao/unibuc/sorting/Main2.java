package pao.unibuc.sorting;

import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;

public class Main2 {
    public static void main(String[] args) {
        Car car1 = new Car(5, "Opel", "sedan");
        Car car2 = new Car(2, "Ford", "hatchback");
        Car car3 = new Car(1, "Ford", "suv");
        Car car4 = new Car(6, "Mazda", "sedan");
        Car car5 = new Car(2, "Ford", "sedan");

        Car[] cars = {car1, car2, car3, car4, car5};

        System.out.println(car1.equals(car2));
        System.out.println(car2.equals(car3));
        System.out.println(car2.equals(car5));

        Arrays.sort(cars);
        Arrays.sort(cars, Collections.reverseOrder());
        printElements(cars);

        Arrays.sort(cars, new CarComparator());
        printElements(cars);

        Arrays.sort(cars, Comparator.comparing(Car::getBrand)
                .thenComparing(Car::getAge)
                .thenComparing(Car::getType));

        printElements(cars);

    }

    private static void printElements(Car[] cars) {
        System.out.println("-----------------");
        for(Car car: cars){
            System.out.println(car);
        }
    }
}

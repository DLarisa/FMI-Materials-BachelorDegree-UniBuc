package pao.unibuc.singleton;

import pao.unibuc.lambda.City;
import pao.unibuc.lambda.District;

import java.util.*;

public class Main2 {

    public static void main(String[] args) {
        try {
            List<City> cities = CsvRepository.getInstance().read("data/cities.csv", City.class);
            Map<String, District> districts = new HashMap<String, District>();
            for (City city : cities) {
                String district = city.getDistrict();
                if (!districts.containsKey(district)) {
                    districts.put(district, new District(district));
                }
                districts.get(district).addCity(city);
            }
            List<District> values = new ArrayList<>(districts.values());
            Collections.sort(values);
            CsvRepository.getInstance().write(values, "data/districts.csv");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}

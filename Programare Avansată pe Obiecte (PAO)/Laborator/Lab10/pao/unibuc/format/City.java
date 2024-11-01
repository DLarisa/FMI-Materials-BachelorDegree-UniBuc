package pao.unibuc.format;

import java.io.Serializable;

public class City implements Serializable {
    private String name;
    private String district;
    private int inhabitants;

    public static City createCity(String line){
        String [] values = line.split(",");
        City city = new City();
        city.setName(values[0]);
        city.setDistrict(values[1]);
        city.setInhabitants(Integer.parseInt(values[2]));
        return city;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public int getInhabitants() {
        return inhabitants;
    }

    public void setInhabitants(int inhabitants) {
        this.inhabitants = inhabitants;
    }
}

package pao.unibuc.lambda;

public class District implements Comparable<District> {
    private String name;
    private int inhabitants;

    public String getName(){
        return name;
    }

    public int getInhabitants(){
        return inhabitants;
    }
    public District(String name){
        this.name = name;
    }
    public void addCity(City city){
        if(name.equals(city.getDistrict())){
            inhabitants += city.getInhabitants();
        }
    }

    @Override
    public String toString() {
        return String.format("%s,%d", name,inhabitants);
    }

    @Override
    public int compareTo(District district) {
        return name.compareTo(district.getName());
    }
}

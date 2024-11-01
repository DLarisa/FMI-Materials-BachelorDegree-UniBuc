package pao.unibuc.lambda;

public class City {

    private String name;
    private String district;
    private int inhabitants;

    public City(String line){
        String [] values = line.split(",");
        if(values.length == 3){
            name = values[0];
            district= values[1];
            inhabitants = Integer.parseInt(values[2]);
        }
    }
    public City() {
    }

    public String getName(){
        return name;
    }

    public String getDistrict(){
        return district;
    }

    public int getInhabitants() {
        return inhabitants;
    }

    @Override
    public String toString() {
        return String.format("%s,%s,%d", name,district,inhabitants);
    }
}

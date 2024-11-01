package pao.unibuc.hashSet;

public class City {
    private String name;
    private String district;

    public static String field = "name";

    public City(String [] values){
        name = values[0];
        district = values[1];
    }
    @Override
    public int hashCode(){
        return "name".equalsIgnoreCase(field) ? name.hashCode() : district.hashCode();
    }
    @Override
    public String toString(){
        return String.format("Name = %s, District = %s", name, district);
    }
    @Override
    public boolean equals (Object object){
        return object instanceof City
                && ("name".equalsIgnoreCase(field) && name.equalsIgnoreCase(((City) object).name)
                || "district".equalsIgnoreCase(field) && district.equalsIgnoreCase(((City)object).district));
    }
}

package pao.unibuc.format;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;

public class CustomCity extends  City implements Externalizable {

    public static CustomCity createCustomCity(City city){
        CustomCity customCity = new CustomCity();
        customCity.setName(city.getName());
        customCity.setDistrict(city.getDistrict());
        customCity.setInhabitants(city.getInhabitants());
        return customCity;
    }
    @Override
    public void writeExternal(ObjectOutput out) throws IOException {
        out.writeUTF(getName());
        out.writeUTF(getDistrict());
        out.writeInt(getInhabitants());
    }

    @Override
    public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {
        setName(in.readUTF());
        setDistrict(in.readUTF());
        setInhabitants(in.readInt());
    }
}

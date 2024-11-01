package pao.unibuc.clone;

import static pao.unibuc.format.Formatter.deserialize;
import static pao.unibuc.format.Formatter.serialize;

public class Cloner {
    public static <T> T clone(T object){
        return deserialize(serialize(object));
    }
}

package pao.unibuc.format;

import java.io.*;

public class Formatter {
    public static <T> byte[] serialize (T object){
        try(ByteArrayOutputStream stream = new ByteArrayOutputStream()){
            new ObjectOutputStream(stream).writeObject(object);
            return stream.toByteArray();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static <T> T deserialize(byte[] bytes) {
        try(ByteArrayInputStream stream = new ByteArrayInputStream(bytes)){
            return (T) new ObjectInputStream(stream).readObject();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }
}

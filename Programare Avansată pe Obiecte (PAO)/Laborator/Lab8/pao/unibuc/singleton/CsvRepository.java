package pao.unibuc.singleton;

import java.io.PrintWriter;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class CsvRepository {

    private static CsvRepository instance;

    private CsvRepository() {
    }

    public static CsvRepository getInstance() {
        if (instance == null) {
            synchronized (CsvRepository.class) {
                if (instance == null) {
                    instance = new CsvRepository();
                }
            }
        }
        return instance;
    }

    @SuppressWarnings("unchecked")
    public <T> List<T> read(String path, Class<T> type) throws Exception {
        List<T> records = new ArrayList<T>();
        Constructor<T> constructor = type.getDeclaredConstructor();
        Field[] fields = type.getDeclaredFields();
        constructor.setAccessible(true);
        for (Field field : fields) {
            field.setAccessible(true);
        }
        for (String line : Files.readAllLines(Paths.get(path))) {
            T record = constructor.newInstance();
            String[] values = line.split(",");
            if (values.length == fields.length) {
                for (int i = 0; i < fields.length; i++) {
                    setField(record, fields[i], values[i]);
                }
            }
            records.add(record);
        }
        return records;
    }

    public <T> void write(List<T> records, String path) throws Exception {
        Field[] fields = records.get(0).getClass().getDeclaredFields();
        for (Field field : fields) {
            field.setAccessible(true);
        }

        try (PrintWriter writer = new PrintWriter(path)) {
            for (T record : records) {
                for (int i = 0; i < fields.length - 1; i++) {
                    Object value = fields[i].get(record);
                    if (value != null) {
                        writer.print(value);
                    }
                    writer.print(",");
                }
                Object value = fields[fields.length - 1].get(record);
                if (value != null) {
                    writer.println(value);
                }
            }
        }
    }

    private void setField(Object object, Field field, String text) throws Exception {
        if (text.isEmpty()) {
            return;
        }
        Object value = null;
        if (String.class.equals(field.getType())) {
            value = text;
        } else {
            String name=Character.toUpperCase(field.getType().getSimpleName().charAt(0)) + field.getType().getSimpleName().substring(1);
            Class<?> type = Class.forName("java.lang." + name + (int.class.equals(field.getType()) ? "eger" : ""));
            Method method = type.getDeclaredMethod("parse" + name, String.class);
            value = method.invoke(null, text);
        }
        field.set(object, value);
    }
}

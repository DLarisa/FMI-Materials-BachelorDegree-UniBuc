package pao.unibuc.format;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.AbstractMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        try {
            List<City> cities = Files.readAllLines(Paths.get("cities.csv"))
                    .stream()
                    .map(City :: createCity)
                    .collect(Collectors.toList());

            List<CustomCity> customCities = cities.stream().map(CustomCity::createCustomCity).collect(Collectors.toList());

            System.out.println(String.format("Serialized size= %d, Externalized size = %d",
                    countAndCheckSerializedBytes(cities), countAndCheckSerializedBytes(customCities)));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static <A,B> Stream <Map.Entry<A,B>> zipStreams (Stream<A> firstStream, Stream<B> secondStream){
        final Iterator<A> iterator = firstStream.iterator();
        return secondStream.filter(item -> iterator.hasNext()).map(item -> new AbstractMap.SimpleEntry<A, B>(iterator.next(), item));
    }

    private static int countAndCheckSerializedBytes(List<?> list){
        byte[] bytes = Formatter.serialize(list);
        List<?> deserializedList = Formatter.deserialize(bytes);
        assert !zipStreams(list.stream(), deserializedList.stream())
                .filter(entry -> !entry.getKey().equals(entry.getValue()))
                .findAny().isPresent();
        return bytes.length;
    }
}

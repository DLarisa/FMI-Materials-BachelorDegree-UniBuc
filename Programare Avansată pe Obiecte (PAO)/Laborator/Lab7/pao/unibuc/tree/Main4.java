package pao.unibuc.tree;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Map;
import java.util.TreeMap;

public class Main4 {
    public static void main(String[] args) {

        Map<String, Integer> map = new TreeMap<String, Integer>();
        try {
            for(String line : Files.readAllLines(Paths.get("cities.csv"))){
                String district = line.split(",")[1];
                if(map.containsKey(district)){
                    map.put(district, map.get(district) + 1);
                }
                else {
                    map.put(district, 1);
                }
            }

            for(Map.Entry<String, Integer> entry : map.entrySet()){
                System.out.println(String.format("%s : %d ", entry.getKey(), entry.getValue()));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}

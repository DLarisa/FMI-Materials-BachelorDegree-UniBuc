package pao.unibuc.aggregate;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

public class Main5 {
    public static void main(String[] args) {
        try {
            aggregate("data/cities.csv", "data/districts.csv");
        } catch (Exception e) {
            System.out.println("exception: " + e.getMessage());
        }
    }

    private static void aggregate(String input, String output) throws Exception {
        Map<String, Integer> inhabitantsByDistrict = new HashMap<>();

        try(BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(input)))){

            while(true){
                String line = reader.readLine();
                if(line == null) break;
                String[] values = line.split(",");
                if(values.length != 4){
                    continue;
                }
                String district = values[2];
                int numberOfInhabitants = Integer.parseInt(values[3]);

                if (inhabitantsByDistrict.containsKey(district)) {
                    inhabitantsByDistrict.put(district, numberOfInhabitants + inhabitantsByDistrict.get(district));
                }
                else{
                    inhabitantsByDistrict.put(district, numberOfInhabitants);
                }
            }

            String[] districts = new String [inhabitantsByDistrict.keySet().size()];
            inhabitantsByDistrict.keySet().toArray(districts);

            try(BufferedWriter writer = new BufferedWriter(new FileWriter(output))){
                for(String district: districts){
                    int inhabitantsNumber = inhabitantsByDistrict.get(district);
                    writer.write(district);
                    writer.write(",");
                    writer.write(Integer.toString(inhabitantsNumber));
                    writer.newLine();
                }
            }
        }
    }
}

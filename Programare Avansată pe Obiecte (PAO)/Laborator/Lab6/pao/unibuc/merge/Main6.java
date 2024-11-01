package pao.unibuc.merge;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class Main6 {
    public static void main(String[] args) {
        try {
            merge("data/output.txt", "data/input1.txt", "data/input2.txt", "data/input3.txt");
        } catch (IOException e) {
            System.out.println("Exception: " + e.getMessage());
        }
    }

    private static void merge (String output, String...inputs) throws IOException {
        if(new File(output).exists()){
            new File(output).delete();
        }

        for(String input : inputs){
            try(FileWriter writer = new FileWriter(output, true)){
                try(FileReader reader = new FileReader(input)){
                    reader.transferTo(writer);
                }
            }
        }
    }
}

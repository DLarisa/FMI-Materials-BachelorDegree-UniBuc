package pao.unibuc.exceptions;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class Main1 {
    public static void main(String[] args) {

        try {
            FileReader reader = new FileReader("data/input.txt");
            reader.close();
            reader.read();
        } catch (FileNotFoundException e) {
            System.out.println("File not found: " + e.getMessage());
        } catch (IOException e) {
            System.out.println("IO exception: " + e);
        } finally{
            new File("data/input.txt").renameTo(new File("data/output.txt"));
        }
    }
}

package pao.unibuc.invert;

import java.awt.*;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;

public class Main7 {
    public static void main(String[] args) {
        try {
            invert("data/input.bmp", "data/output.bmp");
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
        }
    }

    private static void invert (String input, String output) throws Exception {
        try (FileInputStream inputStream = new FileInputStream(input); FileOutputStream outputStream = new FileOutputStream(output)){
            byte[] header = new byte[54];
            inputStream.read(header);
            outputStream.write(header);

            int rgb;
            while((rgb = inputStream.read()) != -1){
                Color color = new Color(rgb);
                int red = 255 - color.getRed();
                int green = 255 - color.getGreen();
                int blue = 255 - color.getBlue();
                outputStream.write(new Color(red, green, blue).getRGB());
            }
        }
    }
}

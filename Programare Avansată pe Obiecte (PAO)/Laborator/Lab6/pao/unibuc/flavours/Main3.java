package pao.unibuc.flavours;

import java.io.FileInputStream;
import java.util.Scanner;

public class Main3 {
    public static void main(String[] args) {
        System.out.println("1. Division by zero");
        System.out.println("2. Out of bounds");
        System.out.println("3. Number format");
        System.out.println("4. File not found");
        System.out.println("5. Infinity recursivity");
        System.out.println("0. Exit");

        try (Scanner scanner = new Scanner(System.in)) {
            loop:
            while (true) {
                try {
                    System.out.println("Select: ");
                    switch (scanner.nextInt()) {
                        case 0:
                            break loop;
                        case 1:
                            System.out.println(1 / 0);
                            break;
                        case 2:
                            System.out.println((new int[1])[4]);
                            break;
                        case 3:
                            Integer.parseInt("text");
                            break;
                        case 4:
                            new FileInputStream("test.txt").read();
                            break;
                        case 5:
                            f(1);
                            break;
                        default:
                            throw new Throwable("Invalid selection");
                    }
                } catch (RuntimeException exception) {
                    System.out.println("Runtime exc: " + exception);
                } catch (Exception exception) {
                    System.out.println("Exception: " + exception);
                } catch (Error error) {
                    System.out.println("Error " + error);
                } catch (Throwable e) {
                    System.out.println("Throwable: " + e);
                }
            }
        }
    }

    public static int f(int i){
        return f(++i);
    }
}

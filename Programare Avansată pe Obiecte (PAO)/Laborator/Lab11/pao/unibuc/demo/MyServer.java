package pao.unibuc.demo;

import java.io.IOException;
import java.util.Scanner;

public class MyServer {
    public static void main(String[] args) {
        try (Server server = new Server(8080);
             MyService service = new MyService()) {
            server.publish("notes", service);
            System.out.println("Server is running, type 'exit' to close it.");
            try(Scanner scanner = new Scanner(System.in)){
                while(true){
                    if(scanner.hasNextLine() && "exit".equals(scanner.nextLine())){
                        System.exit(1);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

package pao.unibuc.executorService;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class Client implements AutoCloseable {

    private Socket socket;
    private PrintWriter printWriter;

    public Client(String host, int port){
        try {
            socket = new Socket(host, port);
            final BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            printWriter = new PrintWriter(socket.getOutputStream());
            new Thread(() -> {
                while(!socket.isClosed()){
                    reader.lines().forEach(System.out::println);
                }
            }).start();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void close() throws Exception {
        socket.close();
    }

    private void send(String text){
        printWriter.println(text);
        printWriter.flush();
    }
    public static void main(String[] args) {
        try(Client client = new Client("localhost", 2020 )){
            System.out.println("Client is running, type 'exit' to close");
            try(Scanner scanner = new Scanner(System.in)){
                while(true){
                    if(scanner.hasNextLine()){
                        String text = scanner.nextLine();
                        if("exit".equals(text)){
                            System.exit(0);
                        }
                        else {
                            client.send(text);
                        }
                    }
                }
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
}

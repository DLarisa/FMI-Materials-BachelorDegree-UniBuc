package pao.unibuc.demo;

import java.awt.*;
import java.util.Scanner;

public class MyClient {
    public static void main(String[] args) {
        MyContract proxy = Proxy.create("tcp://localhost:8080/notes", MyContract.class);

        if(GraphicsEnvironment.isHeadless()){
            System.out.println("Enter command help, create, read, update, delete or exit.");
            try (Scanner scanner = new Scanner(System.in)) {
                while (true) {
                    try {
                        if (scanner.hasNextLine()) {
                            String[] arguments = scanner.nextLine().split("\\|");
                            switch (arguments[0]) {
                                case "help":
                                    System.out.println("create|<title>|<content>");
                                    System.out.println("read");
                                    System.out.println("update|<id>|<title>|<content>");
                                    System.out.println("delete|<id>");
                                    System.out.println("exit");
                                    break;
                                case "create":
                                    System.out.println(proxy.createNote(arguments[1], arguments[2]));
                                    break;
                                case "read":
                                    proxy.readNotes().forEach(note -> System.out.println(note.toCsvString()));
                                    break;
                                case "update":
                                    System.out.println(
                                            proxy.updateNote(new MyNote()
                                                    .id(arguments[1])
                                                    .title(arguments[2])
                                                    .content(arguments[3]))
                                                    ? "Done" : "Failed");
                                    break;
                                case "delete":
                                    System.out.println(proxy.deleteNote(arguments[1])
                                            ? "Done" : "Failed");
                                    break;
                                case "exit":
                                    System.exit(0);
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        else {
            EventQueue.invokeLater(() ->{
                new MyFrame(proxy).setVisible(true);
            });

        }
    }
}

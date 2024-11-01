package pao.unibuc.demo;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

public class Channel {
    private Socket socket;

    public Channel(Socket socket){
        this.socket = socket;
    }

    public <T> void write (T object) throws IOException {
        new ObjectOutputStream(socket.getOutputStream()).writeObject(object);
    }
    public <T> T read () throws IOException, ClassNotFoundException {
        return (T) new ObjectInputStream(socket.getInputStream()).readObject();
    }

    public boolean isClosed(){
        return socket.isClosed();
    }
}

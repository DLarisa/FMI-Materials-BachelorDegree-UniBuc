package pao.unibuc.demo;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.net.ServerSocket;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Server implements AutoCloseable {

    private Map<String, Object> services = new HashMap<String, Object>();
    private ServerSocket socket;

    public Server(int port) throws IOException {
        this.socket = new ServerSocket(port);
        final ExecutorService executorService = Executors.newFixedThreadPool(20 * Runtime.getRuntime().availableProcessors());
        executorService.execute(() -> {
            while(!socket.isClosed()){
                try {
                    final Channel channel = new Channel(socket.accept());
                    executorService.execute(() -> {
                        while(!channel.isClosed()){
                            try {
                                Request request = channel.read();
                                Response response = new Response();
                                process(services.get(request.getService()), request, response);
                                channel.write(response);
                            } catch (IOException e) {
                                e.printStackTrace();
                            } catch (ClassNotFoundException e) {
                                e.printStackTrace();
                            }

                        }
                    });
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        });
    }

    @Override
    public void close() throws Exception {
        socket.close();
    }

    public void process (Object instance, Request request, Response response){
        Method method = Arrays.stream(instance.getClass().getDeclaredMethods())
                .filter(m-> request.getMethod().equals(m.getName()))
                .findAny().get();
        try {
            response.setResult(method.invoke(Modifier.isStatic(method.getModifiers())? null : instance, request.getArguments()));
        } catch (Exception e) {
            response.setException(e);
        }
    }

    public void publish(String name, Object instance){
        services.put(name, instance);
    }

    public void unPublish(String name){
        services.remove(name);
    }
}

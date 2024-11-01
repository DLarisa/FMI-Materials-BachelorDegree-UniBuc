package pao.unibuc.demo;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.net.Socket;
import java.net.URI;

public class Proxy<T> {
    private Proxy(){
    }
    //tcp://host:port/service
    public static <T> T create (String endpoint, Class<T> contract){
        InvocationHandler handler = new InvocationHandler() {
            @Override
            public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                URI uri = URI.create(endpoint);
                try(Socket socket = new Socket(uri.getHost(), uri.getPort())){
                    Request request = new Request(uri.getPath().substring(1), method.getName(), args);
                    Channel transport = new Channel(socket);
                    transport.write(request);
                    Response response = transport.read();
                    if(response.getException() != null){
                        throw response.getException();
                    }
                    return response.getResult();
                }
            }
        };
        return contract.cast(java.lang.reflect.Proxy.newProxyInstance(contract.getClassLoader(), new Class<?>[] {contract}, handler));
    }
}

package pao.unibuc.demo;

import java.io.Serializable;

public class Request implements Serializable {

    private String service;
    private String method;
    private Object[] arguments;

    public Request(String service, String method, Object[] arguments) {
        this.service = service;
        this.method = method;
        this.arguments = arguments;
    }

    public String getService() {
        return service;
    }

    public String getMethod() {
        return method;
    }

    public Object[] getArguments() {
        return arguments;
    }
}

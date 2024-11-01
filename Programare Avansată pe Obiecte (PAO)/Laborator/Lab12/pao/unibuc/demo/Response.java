package pao.unibuc.demo;

import java.io.Serializable;

public class Response implements Serializable {

    private Object result;
    private Exception exception;

    public Response()
    {

    }
    public Response(Object result, Exception exception) {
        this.result = result;
        this.exception = exception;
    }

    public Object getResult() {
        return result;
    }

    public void setResult(Object result) {
        this.result = result;
    }

    public Exception getException() {
        return exception;
    }

    public void setException(Exception exception) {
        this.exception = exception;
    }
}

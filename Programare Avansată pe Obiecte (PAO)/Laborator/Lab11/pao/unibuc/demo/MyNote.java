package pao.unibuc.demo;

import java.io.Serializable;
import java.util.UUID;

public class MyNote implements Serializable {
    private String id;
    private String title;
    private String content;

    public MyNote(){
        id= UUID.randomUUID().toString();
    }
    public MyNote id(String id){
        this.id = id;
        return this;
    }
    public MyNote title(String title){
        this.title = title;
        return this;
    }
    public MyNote content(String content){
        this.content = content;
        return this;
    }

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    @Override
    public String toString() {
        return String.format("%s|%s|%s", id, title, content);
    }
}

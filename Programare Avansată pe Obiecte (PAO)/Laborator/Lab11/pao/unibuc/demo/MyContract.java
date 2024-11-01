package pao.unibuc.demo;

import java.util.List;

public interface MyContract {
    MyNote createNote(String title, String content) throws Exception;
    List<MyNote> readNotes() throws Exception;
    boolean updateNote (MyNote note) throws Exception;
    boolean deleteNote (String id) throws Exception;
}

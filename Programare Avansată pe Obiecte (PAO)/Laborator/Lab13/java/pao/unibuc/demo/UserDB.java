package pao.unibuc.demo;

import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class UserDB {

    private static UserDB instance;
    Map<String, User> userMap = new HashMap<String, User>();

    private UserDB(){
        addUser("John", "test1@abc.com", new String[]{"Mary", "George"});
        addUser("Mary", "test2@abc.com", new String[]{"Matilda", "George", "Paul"});
        addUser("Matilda", "test3@abc.com", new String[]{"Mary", "George", "John"});
        addUser("George", "test4@abc.com", new String[]{"Mary", "John"});
        addUser("Paul", "test5@abc.com", new String[]{"Mary", "George", "Matilda"});
    }

    public void addUser(String name, String email, String [] contacts){
        User user = new User(name, email);
        user.setContacts(Arrays.asList(contacts));
        userMap.put(name, user);
    }
    public static UserDB getInstance(){
        if(instance == null){
            synchronized (UserDB.class){
                if(instance == null){
                    instance = new UserDB();
                }
            }
        }
        return instance;
    }

    public User getUser (String name){
        return userMap.get(name);
    }

    public Collection<User> getAllUsers(){
        return userMap.values();
    }
}

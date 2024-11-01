package pao.unibuc.streams;

public class User {
    private int id;
    private String lastName;
    private String firstName;

    public User(String [] values){
        if(values.length == 3){
            id = Integer.parseInt(values[0]);
            lastName = values[1];
            firstName = values[2];
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", lastName='" + lastName + '\'' +
                ", firstName='" + firstName + '\'' +
                '}';
    }
    @Override
    public int hashCode(){
        int hash = 7;
        hash = 31 * hash + id;
        hash = 31 * hash + (lastName == null ? 0 : lastName.hashCode());
        hash = 31 * hash + (firstName == null ? 0: firstName.hashCode());
        return hash;
    }
    @Override
    public boolean equals(Object o){
        if(this == o) return true;
        if(o == null) return false;
        if(this.getClass() != o.getClass()) return false;
        User user = (User)o;
        return id == user.getId() && lastName.equals(user.getLastName()) && firstName.equals(user.getFirstName());
    }
}

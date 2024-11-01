package pao.unibuc.streams;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Task {

    private int id;
    private int daysToImplement;
    private Date createdDate;
    private TaskType type;
    private Status status;
    private Priority priority;
    private User assignee;
    private List<User> observers;

    public Task(String [] values){
        if(values.length == 6){
            id = Integer.parseInt(values[0]);
            daysToImplement = Integer.parseInt(values[0]);
            try {
                createdDate = new SimpleDateFormat("dd/MM/yyyy").parse(values[2]);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            type = TaskType.valueOf(values[3]);
            status = Status.valueOf(values[4]);
            priority = Priority.valueOf(values[5]);
            observers = new ArrayList<>();
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDaysToImplement() {
        return daysToImplement;
    }

    public void setDaysToImplement(int daysToImplement) {
        this.daysToImplement = daysToImplement;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public TaskType getType() {
        return type;
    }

    public void setType(TaskType type) {
        this.type = type;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Priority getPriority() {
        return priority;
    }

    public void setPriority(Priority priority) {
        this.priority = priority;
    }

    public User getAssignee() {
        return assignee;
    }

    public void setAssignee(User assignee) {
        this.assignee = assignee;
    }

    public List<User> getObservers() {
        return observers;
    }

    public void setObservers(List<User> observers) {
        this.observers = observers;
    }

    public void assignTo(User user){
        this.assignee = user;
        this.observers.add(user);
        this.status = Status.IN_PROGRESS;
    }

    @Override
    public String toString() {
        return "Task{" +
                "id=" + id +
                ", daysToImplement=" + daysToImplement +
                ", createdDate=" + new SimpleDateFormat("dd/MM/yyyy").format(createdDate) +
                ", type=" + type +
                ", status=" + status +
                ", priority=" + priority +
                ", assignee=" + (assignee != null ? assignee.getLastName() + " " + assignee.getFirstName()  : "") +
                '}';
    }
}

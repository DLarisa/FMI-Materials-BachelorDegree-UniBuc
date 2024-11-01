package pao.unibuc.streams;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.*;

public class Main {
    public static void main(String[] args) throws IOException {

        List<Task> tasks = new ArrayList<>();
        List<User> users = new ArrayList<>();

        for(String line : Files.readAllLines(Paths.get("data/users.csv"))){
            users.add(new User(line.split(",")));
        }
        System.out.println(String.format("Total users: %d", users.stream().count()));
        for(String line : Files.readAllLines(Paths.get("data/tasks.csv"))){
            tasks.add(new Task(line.split(",")));
        }
        System.out.println(String.format("Total tasks: %d", tasks.stream().count()));


        System.out.println("Critical tasks: ");
        tasks.stream().filter(t -> t.getPriority().equals(Priority.CRITICAL))
                .sorted(Comparator.comparing(Task::getCreatedDate))
                .forEach(System.out::println);

        System.out.println("First 10 users: ");
        users.stream().sorted(Comparator.comparing(User::getLastName))
                .limit(10)
                .forEach(System.out::println);

        tasks.get(0).assignTo(users.get(5));
        tasks.get(8).assignTo(users.get(2));
        tasks.get(10).assignTo(users.get(12));
        tasks.get(7).assignTo(users.get(12));

        System.out.println("Users that have tasks assigned:");
        tasks.stream().filter(t -> t.getAssignee() != null)
        .map(Task:: getAssignee)
       .distinct()
        .forEach(System.out::println);

        tasks.get(0).getObservers().add(users.get(10));

        System.out.println("Observers: ");
        tasks.stream().filter(t -> !t.getObservers().isEmpty())
                .flatMap(t -> t.getObservers().stream())
                .distinct().forEach(System.out::println);


        System.out.println(tasks.stream().max(Comparator.comparing(Task:: getDaysToImplement)).get());
        System.out.println(tasks.stream().min(Comparator.comparing(Task:: getCreatedDate).reversed()).get());

        System.out.println(String.format("Total working time: %d days",
                tasks.stream().map(Task::getDaysToImplement).reduce(0, (x, y) -> x + y)));

        System.out.println("Tasks to do:");
        List<Task> tasksToDo = tasks.stream()
                .filter(t-> t.getStatus().equals(Status.IN_PROGRESS) || t.getStatus().equals(Status.OPEN))
                .collect(Collectors.toList());
        tasksToDo.stream().forEach(System.out::println);

        String busyUsers = tasks.stream().filter(t-> t.getStatus().equals(Status.IN_PROGRESS))
                .map(t -> t.getAssignee().getLastName() + " " + t.getAssignee().getFirstName())
                .collect(Collectors.joining(";"));
        System.out.println(busyUsers);

        System.out.println(String.format("Average time to solve a task: %f days ",
                tasks.stream().collect(averagingInt(Task:: getDaysToImplement))));

        System.out.println(String.format("total time to solve a task: %d days ",
                tasks.stream().collect(summingInt(Task:: getDaysToImplement))));


        System.out.println("Tasks by type: ");
        Map<TaskType, List<Task>> tasksByType = tasks.stream().collect(groupingBy(Task::getType));
        for(TaskType type : tasksByType.keySet()){
            System.out.println(type + " -> " + tasksByType.get(type).size());
        }

        System.out.println("Tasks by priority: ");
        Map<Priority, Long>  tasksByPriority = tasks.stream().collect(groupingBy(Task::getPriority, counting()));
        for(Priority priority : tasksByPriority.keySet()){
            System.out.println(priority + " -> " + tasksByPriority.get(priority));
        }
    }
}

package pao.unibuc.association;

public class Main {
    public static void main(String[] args) {
        Engine engine = new Engine("diesel", 1.6f);
        Car car = new Car("red", engine);
        engine.capacity = 2f;
        System.out.println(engine == car.engine);
        System.out.println(car.engine.capacity);

        Player player = new Player("Alin", "football");
        Team team = new Team("Barcelona", player);
        player.sport = "tennis";
        System.out.println(player == team.player);
        System.out.println(team.player.sport);
        Team team2 = new Team("Real Madrid", player);
        System.out.println(player == team2.player);
    }
}

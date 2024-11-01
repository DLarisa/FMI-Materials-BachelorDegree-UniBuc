package pao.unibuc.exceptions;

import java.util.Random;

public class Main2 {
    public static void main(String[] args) {
        String [] planets = {"Neptune", "Uranus","Saturn", "Jupiter", "Mars", "Earth", "Venus", "Mercury", "Sun"
        };

        for(String planet: planets){
            try {
                visit(planet);
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            finally{
                System.out.println(String.format("Leaving %s ..", planet));
            }
        }
    }

    private static void visit (String planet) throws Exception {
        System.out.println(String.format("Visiting %s.. ", planet));

        if("Sun".equals(planet)){
            System.exit(0);
        }
        if(new Random().nextBoolean()){
            throw new Exception("something went wrong..");
        }
        System.out.println("all went well..");
    }
}

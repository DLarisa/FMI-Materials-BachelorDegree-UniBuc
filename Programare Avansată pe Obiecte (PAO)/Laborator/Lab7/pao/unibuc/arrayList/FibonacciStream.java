package pao.unibuc.arrayList;

import java.util.ArrayList;
import java.util.List;

public class FibonacciStream {

    private static List<Integer> values = new ArrayList<>();

    static {
        values.add(1);
        values.add(2);
    }

    public static int get(int n){
        if(n > values.size()){
            for(int i= values.size(); i< n; i++){
                values.add(values.get(i-2) + values.get(i-1));
            }
        }
        return values.get(n-1).intValue();
    }

}

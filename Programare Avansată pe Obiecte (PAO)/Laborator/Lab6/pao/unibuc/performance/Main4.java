package pao.unibuc.performance;

public class Main4 {
    public static void main(String[] args) {
        countNormally(5000000);
        countWithException(5000000);
    }

    private static int countNormally(int n){
        long start = System.currentTimeMillis();
        int count = 0;
        for(int i = 0; i< n; i++){
            if(i%2 == 0){
                count ++;
            }
        }
        long end = System.currentTimeMillis();
        System.out.println(end-start);
        return count;
    }

    private static int countWithException(int n){
        long start = System.currentTimeMillis();
        int count = 0;
        for(int i = 0; i< n; i++){
            if(i%2 == 0){
                try {
                    throw new Exception();
                } catch (Exception e) {
                   count++;
                }
            }
        }
        long end = System.currentTimeMillis();
        System.out.println(end-start);
        return count;
    }
}

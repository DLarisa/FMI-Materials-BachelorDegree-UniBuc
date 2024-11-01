package pao.unibuc.strings;

public class Main2 {
    public static void main(String[] args) {
        String label1 = "test";
        String label3 = "test";
        String label2 = new String("test");
        String label4 = new String("Test");

        System.out.println(label1 == label3);
        System.out.println(label1 == label2);
        System.out.println(label1.equals(label2));
        System.out.println(label1.equalsIgnoreCase(label4));

        String row = "   This" + "  is" + " a " + "sentence  ";
        String row2 = "     This *is a short, sentence.  !!  ";
        System.out.println(row.toUpperCase());
        System.out.println(row.toLowerCase());
        System.out.println(row.replaceAll("i", "*"));
        System.out.println(row.replaceAll("[aeiouAEIOU]", "*"));
        System.out.println(row2.trim());
        System.out.println(row2.substring(3, 10));
        System.out.println("----------------");
        String [] words = row2.split("[ *,.!]+");
        for(String word: words){
            System.out.println(word);
        }
        String row3 = "     6  ";
        String row4 = "       ";
        String row5 = "";
        System.out.println("isEmpty: " + row3.isEmpty()+", isBlank: " + row3.isBlank());
        System.out.println("isEmpty: " + row4.isEmpty()+", isBlank: " + row4.isBlank());
        System.out.println("isEmpty: " + row5.isEmpty()+", isBlank: " + row5.isBlank());
    }
}

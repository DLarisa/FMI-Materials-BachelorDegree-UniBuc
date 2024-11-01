package pao.unibuc.strings;

public class Main3 {
    public static void main(String[] args) {

        StringBuilder builder= new StringBuilder();
        builder.append("This ").append("is ")
                .append("a ")
                .append("longer ")
                .append("sentence");

        System.out.println(builder.toString());
        System.out.println(builder.replace(1, 4, "hat"));
        System.out.println(builder.deleteCharAt(10));

        StringBuffer strBuffer = new StringBuffer();
        strBuffer.append("This is")
                .append(" another ")
                .append(" string ");
        System.out.println(strBuffer.toString());
        System.out.println(strBuffer.reverse());
    }
}

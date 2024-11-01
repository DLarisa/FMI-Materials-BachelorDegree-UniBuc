package pao.unibuc.linkedList;

import java.io.File;


public class Main5 {
    public static void main(String[] args) {
        Folder root = new Folder(new File("folder2"));

        for(int i = 0; i < 4; i++){
            System.out.println(String.format("Subfolders for depth %d: ", i));
            for(File file: root.getSubfolders(i)){
                System.out.println(file.getName());
            }
            System.out.println();
        }
    }
}

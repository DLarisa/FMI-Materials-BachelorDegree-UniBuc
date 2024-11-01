package pao.unibuc.linkedList;

import java.io.File;
import java.security.InvalidParameterException;
import java.util.*;

public class Folder {
    private File file;

    public Folder (File file){
        if(file == null || !file.exists() || !file.isDirectory()){
            throw new InvalidParameterException();
        }
        this.file = file;
    }

    private Map.Entry<File, Integer> entry (File file, int depth){
        return new AbstractMap.SimpleEntry<File, Integer> (file, depth);
    }

    public File[] getSubfolders(int depth){
        if(depth < 0){
            return new File[]{};
        }
        else if (depth == 0){
            return new File[]{file};
        }
        else {
            List<File> files = new ArrayList<File>();
            Queue<Map.Entry<File, Integer>> queue = new LinkedList<Map.Entry<File, Integer>>();
            queue.add(entry(file, 0));

            while(queue.size() > 0){
                Map.Entry<File, Integer> entry = queue.poll();
                if(entry.getValue() == depth){
                    files.add(entry.getKey());
                }
                else if (entry.getValue() < depth){
                    for(File file : entry.getKey().listFiles()){
                        if(file.isDirectory()){
                            queue.add(entry(file, entry.getValue() + 1));
                        }
                    }
                }
            }

            File[] array = new File[files.size()];
            files.toArray(array);
            Arrays.sort(array);
            return array;
        }
    }
}

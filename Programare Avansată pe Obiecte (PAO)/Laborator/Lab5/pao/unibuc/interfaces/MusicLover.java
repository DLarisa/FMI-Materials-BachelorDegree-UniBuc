package pao.unibuc.interfaces;

public interface MusicLover {
    void sing();

    default String test(){
        return "testing from music..";
    }
}

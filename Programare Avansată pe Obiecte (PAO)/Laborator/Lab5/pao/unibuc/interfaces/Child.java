package pao.unibuc.interfaces;

public class Child implements Human, MusicLover {
    @Override
    public void run() {
        System.out.println("Child running..");
    }

    @Override
    public void speak() {
        System.out.println("Child speaking..");
    }

    @Override
    public String test() {
        return Human.super.test() + ", " + MusicLover.super.test();
    }

    @Override
    public void sing() {
        System.out.println("Child singing..");
    }
}

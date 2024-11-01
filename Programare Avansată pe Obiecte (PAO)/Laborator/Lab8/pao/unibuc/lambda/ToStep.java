package pao.unibuc.lambda;

import java.util.Collections;
import java.util.List;
import java.util.function.Consumer;

public class ToStep implements Step {

    private Consumer<Exchange> consumer;

    public ToStep(Consumer<Exchange> consumer){
        this.consumer = consumer;
    }

    @Override
    public List<Exchange> process(List<Exchange> exchanges) {
       exchanges.forEach(consumer);
       return Collections.emptyList();
    }
}

package pao.unibuc.lambda;

import java.util.List;
import java.util.function.Consumer;

public class TransformStep implements Step {
    private Consumer<Exchange> consumer;

    public TransformStep(Consumer<Exchange> consumer){
        this.consumer = consumer;
    }

    @Override
    public List<Exchange> process(List<Exchange> exchanges) {
        exchanges.forEach(consumer);
        return exchanges;
    }
}

package pao.unibuc.lambda;

import java.util.List;
import java.util.function.Supplier;
import java.util.stream.Collectors;

public class FromStep implements Step {
    private Supplier<List<?>> supplier;

    public FromStep(Supplier<List<?>> supplier){
        this.supplier = supplier;
    }
    @Override
    public List<Exchange> process(List<Exchange> exchanges) {
        return supplier.get().stream().map(body -> new Exchange(body)).collect(Collectors.toList());
    }
}

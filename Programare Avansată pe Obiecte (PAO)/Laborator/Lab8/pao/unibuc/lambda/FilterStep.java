package pao.unibuc.lambda;

import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class FilterStep implements Step {

    private Predicate<Exchange> predicate;

    public FilterStep(Predicate<Exchange> predicate){
        this.predicate = predicate;
    }
    @Override
    public List<Exchange> process(List<Exchange> exchanges) {
        return exchanges.stream().filter(predicate).collect(Collectors.toList());
    }
}

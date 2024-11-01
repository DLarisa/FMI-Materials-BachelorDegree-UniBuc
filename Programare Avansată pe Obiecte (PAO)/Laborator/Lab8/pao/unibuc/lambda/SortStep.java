package pao.unibuc.lambda;

import java.util.Comparator;
import java.util.List;

public class SortStep implements Step {

    private Comparator<Exchange> comparator;

    public SortStep (Comparator<Exchange> comparator){
        this.comparator = comparator;
    }
    @Override
    public List<Exchange> process(List<Exchange> exchanges) {
        exchanges.sort(comparator);
        return exchanges;
    }
}

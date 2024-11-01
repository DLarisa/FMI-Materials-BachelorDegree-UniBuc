package pao.unibuc.lambda;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

public class AggregateStep implements Step {
    private Function<Exchange, Object> criterion;
    private Aggregator<Exchange> aggregator;

    public AggregateStep (Function<Exchange, Object> criterion, Aggregator<Exchange> aggregator){
        this.criterion = criterion;
        this.aggregator = aggregator;
    }

    @Override
    public List<Exchange> process(List<Exchange> exchanges) {
        final Map<Object, Exchange> map = new HashMap<Object, Exchange>();
        exchanges.stream().forEach(exchange -> {
            Object key = criterion.apply(exchange);
            map.put(key, aggregator.aggregate(map.get(key), exchange));
        });
        return new ArrayList<Exchange>(map.values());
    }
}

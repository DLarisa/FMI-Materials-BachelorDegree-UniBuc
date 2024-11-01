package pao.unibuc.lambda;

@FunctionalInterface
public interface Aggregator<T> {
    T aggregate (T previous, T current);
}

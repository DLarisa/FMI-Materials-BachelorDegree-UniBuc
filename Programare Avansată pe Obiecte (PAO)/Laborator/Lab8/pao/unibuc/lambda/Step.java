package pao.unibuc.lambda;

import java.util.List;

public interface Step {
    List<Exchange> process (List<Exchange> exchanges);
}

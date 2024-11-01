package Demo;

import java.util.ArrayList;
import java.util.List;

// The Command interface
interface Order
{
	void execute();
}

// The receiver 
class Stock
{
	private String name ="my stock";
	private int stockQuantity = 100;
	
	public boolean buy(final int requiredQuantity) 
	{ 
		if (stockQuantity < requiredQuantity)
		{
			System.out.println("Can't buy your requested ");
			return false;
		}
		
		System.out.println("Buying " + name + " quantity " + requiredQuantity);
		stockQuantity -= requiredQuantity;
		return true;
	}
	
	public void sell(final int soldQuantity)
	{
		stockQuantity += soldQuantity;
		System.out.println("Sold " + soldQuantity);
	}
}

// Two concrete commands
class BuyStock implements Order 
{
	private Stock stock; // Caching the receiver object
	private int numStocksToBuy; 
	
	public BuyStock(Stock _stock, int numToBuy ) { stock = _stock; numStocksToBuy = numToBuy; }
	public void execute() { stock.buy(numStocksToBuy); }
}

class SellStock implements Order 
{
	private Stock stock; // Caching the receiver object
	private int numStocksToSell; 
	
	public SellStock(Stock _stock, int numToSell ) { stock = _stock; numStocksToSell = numToSell; }
	public void execute() { stock.sell(numStocksToSell); }
}

// An invoker object
class Broker 
{
	private List<Order> orderList = new ArrayList<Order>();
	
	public void takeOrder(Order order) { orderList.add(order); }
	
	public void executeOrders()
	{
		for (Order order : orderList)
		{
			order.execute();
		}
		orderList.clear();
	}
}

public class CommandDemo
{
	public static void main(String[] args)
	{
		Stock stock = new Stock();
		BuyStock orderBuy1 = new BuyStock(stock, 20);
		BuyStock orderBuy2 = new BuyStock(stock, 120);
		SellStock sell1 = new SellStock(stock, 150);
		
		// Create and take orders
		Broker broker = new Broker();
		broker.takeOrder(orderBuy1);
		broker.takeOrder(orderBuy2);
		broker.takeOrder(sell1);
		broker.takeOrder(orderBuy2);
			
		// Execute broker orders at his own pace
		broker.executeOrders();
	}
}


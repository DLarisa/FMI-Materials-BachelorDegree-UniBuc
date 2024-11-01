package Demo;


// Visitor interface. Need to define a visit method for each element in the hierarchy !
public interface ComputerPartVisitor
{
	public void visit(Computer computer);
	public void visit(Keyboard keyboard);
	public void visit(Monitor monitor);
}

//// Elements hierarchy ///////////////
interface ComputerPart 
{
	public void accept(ComputerPartVisitor visitor);
	public String getState();
	public int getWatt(); // consumption. Would be nice to change dynamically
}

class Keyboard implements ComputerPart
{
	@Override
	public void accept(ComputerPartVisitor visitor) { visitor.visit(this); }
	public String getState() { return "Working"; }
	public int getWatt() { return 100; }
}

class Monitor implements ComputerPart
{
	@Override
	public void accept(ComputerPartVisitor visitor) { visitor.visit(this); }
	public String getState() { return "Working"; }
	public int getWatt() { return 1020; }

}

class Computer implements ComputerPart
{
	public ComputerPart [] parts;
	
	public Computer()
	{
		parts = new ComputerPart[]{new Keyboard(), new Monitor()};
	}
	
	@Override
	public void accept(ComputerPartVisitor visitor) 
	{
		for (ComputerPart part : parts)
			part.accept(visitor);
		
		visitor.visit(this);
	}
	
	public String getState() { return "Working"; }
	public int getWatt() { return 1050; }
}


///////// Concrete visitors ///////////////
class ComputerPartDebuggingVisitor implements ComputerPartVisitor
{
	@Override 
	public void visit(Computer computer) { System.out.println("Computer" + computer.getState()); }
	@Override 
	public void visit(Keyboard keyboard) { System.out.println("Keyboard" + keyboard.getState()); }
	@Override 
	public void visit(Monitor monitor) { System.out.println("Monitor" + monitor.getState()); }
}

class ComputerPartPowerConsumptionVisitor implements ComputerPartVisitor
{
	@Override 
	public void visit(Computer computer) { powerAcc += computer.getWatt(); }
	@Override 
	public void visit(Keyboard keyboard) { powerAcc += keyboard.getWatt(); }
	@Override 
	public void visit(Monitor monitor) { powerAcc += monitor.getWatt(); }
	
	public int getTotalPower() { return powerAcc; }
	private int powerAcc = 0;
}

public class VisitorDemo
{
	public static void main(String[] args)
	{
		// Important thing to notice: check how we implemented 2 operations without changing the objects. 
		// We can implement N more if the hirarchy of elements doesn't change 
		ComputerPartDebuggingVisitor debuggingStateVisitor = new ComputerPartDebuggingVisitor();
		ComputerPartPowerConsumptionVisitor powerConsumptionVisitor = new ComputerPartPowerConsumptionVisitor();
		
		ComputerPart computer = new Computer();
		computer.accept(debuggingStateVisitor);
		
		computer.accept(powerConsumptionVisitor);
		System.out.println("Total consumption: " + powerConsumptionVisitor.getTotalPower());
	}
}


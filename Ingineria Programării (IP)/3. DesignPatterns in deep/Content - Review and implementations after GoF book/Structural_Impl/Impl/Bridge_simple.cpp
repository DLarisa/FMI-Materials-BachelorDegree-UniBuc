#include <iostream>
#include <string>
using namespace std;


// Implementation and its derived classes
class IColor
{
public:
	virtual string getColor() = 0;
};

class RedColor : public IColor
{
public:
	string getColor() { return "red"; }
};

class BlueColor : public IColor
{
public:
	string getColor() { return "blue"; }
};


// Abstraction and its refined abstractions
class IShape
{
public:
	IShape(IColor* impl = nullptr) { setImpl(impl); }
	virtual string draw() = 0;
	virtual void setImpl(IColor* impl) { m_impl = impl; }

protected:
	virtual IColor* getImpl() { return m_impl; }

private:
	IColor* m_impl;		// This can reside in refined abstractions too
};

class Circle : public IShape
{
public:
	Circle(IColor* impl = nullptr) : IShape(impl) {}

	string draw() override
	{
		return "Draw circle with " + getImpl()->getColor();
	}
};

class Square : public IShape
{
public:
	Square(IColor* impl = nullptr) : IShape(impl) {}

	string draw() override
	{
		return "Draw square with " + getImpl()->getColor();
	}
};

int main()
{
	IColor* red = new RedColor();
	IColor* blue = new BlueColor();

	IShape* circle = new Circle(red);
	IShape* square = new Square(blue);

	cout << circle->draw() << endl;
	cout << square->draw() << endl;

	circle->setImpl(blue);
	cout << circle->draw() << endl;

	return 0;
}

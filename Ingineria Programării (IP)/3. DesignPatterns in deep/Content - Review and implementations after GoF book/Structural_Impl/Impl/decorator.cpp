#include <iostream>

using namespace std;

class VisualComponent
{
public:
	virtual void draw() = 0;
	virtual void resize() = 0;
};

class Decorator : public VisualComponent
{
public:
	Decorator(VisualComponent* component) : m_component(component) {}

	virtual void draw() override { m_component->draw(); }
	virtual void resize() override { m_component->resize(); }

protected:
	VisualComponent* m_component;
};

class TextView : public VisualComponent
{
public:
	TextView() {}

	virtual void draw() override {  }
	virtual void resize() override {  }
};

class BorderDecorator : public Decorator
{
public:
	BorderDecorator(VisualComponent* component, const float borderWidth)
		: Decorator(component)
		, m_borderWidth(borderWidth)
	{}

	virtual void draw() override 
	{ 
		m_component->draw(); 
		drawBorder();
	}

protected:
	void drawBorder() { }

private:
	float m_borderWidth;
};

class ScrollDecorator : public Decorator
{
public:
	ScrollDecorator(VisualComponent* component)
		: Decorator(component)
	{}

	virtual void draw() override
	{
		m_component->draw();
		drawScroll();
	}

protected:
	void drawScroll() { }
};

int main()
{
	TextView* tv = new TextView();
	ScrollDecorator* scrollTv = new ScrollDecorator(tv);
	BorderDecorator* borderAndScrollTv = new BorderDecorator(scrollTv, 123);

	borderAndScrollTv->draw();
	borderAndScrollTv->resize();

	// OR :

	//VisualComponent* customizedText = new BorderDecorator(new ScrollDecorator(new TextView()), 123);

	

	return 0;
}
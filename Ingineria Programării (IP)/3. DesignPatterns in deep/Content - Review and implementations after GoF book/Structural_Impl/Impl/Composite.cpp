#include <iostream>
#include <list>
using namespace std;


// Component object: client work with this interface only
class Graphics
{
public:
	virtual void Draw() const = 0;
	virtual void AddChild(Graphics*) {}
	virtual void RemoveChild(Graphics*) {}
};

// Two leafs:
class Line : public Graphics
{
public:
	virtual void Draw() const {}
};

class Rectangle : public Graphics
{
public:
	virtual void Draw() const {}
};

// THis is a composite !
class Picture : public Graphics
{
public:
	virtual void Draw() const
	{
		for (const Graphics* g : m_children)
		{
			g->Draw();
		}
	}

	virtual void AddChild(Graphics* g) { m_children.push_back(g); }
	virtual void RemoveChild(Graphics* g) { m_children.remove(g); }

private:
	list<Graphics*> m_children;
};


int main()
{
	Line l;
	Rectangle r;
	Picture p1;
	p1.AddChild(&l);
	p1.AddChild(&r);

	Picture p2; // picture in picture
	p2.AddChild(&p1);
	Rectangle r2;
	p2.AddChild(&r2);

	/////////////////
	// Client code: he doesn't have to know what's behind. For him, composites and leafs are treated uniformly
	Graphics* object = &p2;
	object->Draw();
	

	return 0;
}


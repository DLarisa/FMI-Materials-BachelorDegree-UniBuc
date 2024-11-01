#include <iostream>
#include <istream>
#include <string.h>
using namespace std;

struct Point 
{ 
	Point() : x(-1), y(-1) {}
	float x, y; 

	bool isInvalid() { return x == -1 && y == -1; }
};
class Event {};

// Interface
class Graphics
{
public:
	virtual ~Graphics() {}
	virtual void Draw(const Point& pos) = 0;	
	virtual void HandleMouse(Event& event) = 0;
};

// Image is used to display a image file from a stream (e.g. disk file)
class Image : public Graphics
{
public:
	Image(const char* file) {} // Loads image from a file..
	virtual ~Image() {}
	
	virtual void Draw(const Point& pos) {}
	virtual void HandleMouse(Event& event) {}
	virtual const Point& GetExtent() { static Point res; res.x = 1; res.y = 2; return res; } // Returns the image size
};

// The proxy for image
class ImageProxy : public Graphics
{
public:
	ImageProxy(const char* filePath)
	{
		m_filePath = strdup(filePath);
		m_image = nullptr;
	}
	virtual ~ImageProxy() 
	{ 
		if (m_image)
		{
			delete m_image;
			m_image = nullptr;
		}

		delete m_filePath;
		m_filePath = nullptr;
	}

	virtual void Draw(const Point& pos)
	{
		getImage()->Draw(pos);
	}

	virtual void HandleMouse(Event& event)
	{
		getImage()->HandleMouse(event);
	}

	virtual const Point& GetExtent() 
	{ 
		// If not already cached, compute the extent
		if (m_extent.isInvalid())
			m_extent = getImage()->GetExtent();

	} // Returns the image size

protected:
	Image* getImage() 
	{ 
		// Someone needs the image...create it if not already
		if (m_image == nullptr)
			m_image = new Image(m_filePath);

		return m_image; 
	}

private:
	Image* m_image;
	Point m_extent;
	char* m_filePath;
};

class WordDocument
{
public:
	WordDocument() {}
	void Insert(Graphics*) {}
	// Add functions here to draw pages and use objects like image ...
};

int main()
{
	WordDocument* doc = new WordDocument();
	doc->Insert(new Image("f.pag"));

	return 0;
}
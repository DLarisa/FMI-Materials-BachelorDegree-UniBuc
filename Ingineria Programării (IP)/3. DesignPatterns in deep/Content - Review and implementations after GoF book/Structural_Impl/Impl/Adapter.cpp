#include <iostream>

using namespace std;

class IPlayer
{
public:
	virtual void playSoundFile(const char* filename) = 0;
	virtual void playVideoFile(const char* filename) = 0;
};

// Two off the shelve files to play sound and video (Adaptee)
class Mp3Player
{
public:
	virtual void playMp3(const char*filename) {}
};

class VlcPlayer
{
public:
	virtual void playAvi(const char* filename) {}
};

// Adapter
class CustomizedPlayer : public IPlayer
{
public:
	virtual void playSoundFile(const char* filename)
	{
		// Possibly other transforms...
		m_pAudioPlayer.playMp3(filename);
	}

	virtual void playVideoFile(const char* filename)
	{
		// Possibly other transforms...
		m_pVideoPlayer.playAvi(filename);
	}

protected:
	Mp3Player m_pAudioPlayer;
	VlcPlayer m_pVideoPlayer;
};

int main()
{
	
	IPlayer* player = new CustomizedPlayer();
	player->playSoundFile("e.mp3");
	player->playVideoFile("e.avi");

	return 0;
}
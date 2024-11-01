#include <iostream>

using namespace std;


class Command
{
public:
	virtual ~Command() {}
	virtual void Execute() = 0;

protected:
	Command() {}
	Command(const Command&) = delete;
};

template <typename Receiver>
class SimpleCommand : public Command
{
public:
	using Action = void(Receiver::*)(); // Pointer to a function in receiver; can do simple parametrization also
	SimpleCommand(Receiver* r, Action a) : receiver(r), action(a) {}

	void Execute() 
	{ 
		(receiver->*action)(); 
	}

private:
	Action action;
	Receiver* receiver;
};

int main()
{
	class MyReceiverClass { public: void customAction() { cout << "action!"; } };
	MyReceiverClass receiverInst;

	SimpleCommand<MyReceiverClass> commandInst(&receiverInst, &MyReceiverClass::customAction);
	commandInst.Execute();

	return 0;
}


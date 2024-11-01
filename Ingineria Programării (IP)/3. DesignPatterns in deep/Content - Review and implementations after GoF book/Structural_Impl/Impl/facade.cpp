#include <iostream>
using namespace std;


class Token {};

class Scanner
{
	Scanner(istream& stream) : m_inputStream(stream){}
	virtual ~Scanner() {}

	virtual Token& Scan() {} // generates the next token from input stream

private:
	istream& m_inputStream;
};

class CodeGenerator;
class BytecodeStream; // Output of a machine-code

// THis is a hierarchy of nodes - a composite actually. It defines an interface for both composites and leafs
class ProgramNode
{
public:

	virtual void Add(ProgramNode*);
	virtual void Remove(ProgramNode*);
	virtual void Traverse(CodeGenerator&); //traverse children and using a code generator to generate machine code for this node

protected:
	ProgramNode();
};

class StatementNode;
class ExpressionNode;

class CodeGenerator
{
public:
	virtual void Visit(StatementNode*);
	virtual void VIsit(ExpressionNode*);
	// ... all other type of nodes | Using a Visitor pattern to generate machine code

protected:
	CodeGenerator(BytecodeStream&);

protected:
	BytecodeStream& m_output;	// Where to write the output
};

class ExpressionNode : ProgramNode
{
public:
	void Traverse(CodeGenerator& cg)
	{
		cg.Visit(this);

		// for each children C of this node
		//  C->Traverse(cg)
	}

// BUilder pattern, it's used by Parser to create nodes
class ProgramNodeBuilder
{
public:
	ProgramNodeBuilder();

	virtual ProgramNode* NewVariable(const char* varName) const { return nullptr; }
	virtual ProgramNode* NewAssignment(const char* variable, ProgramNode* expression) const { return nullptr; }
	virtual ProgramNode* NewCondition(ProgramNode* condition, ProgramNode* trueBranch, ProgramNode* falseBranch) const { return nullptr; }

	ProgramNode* GetRootNode() { return m_root; }

private:
	ProgramNode* m_root; // this is the root of the program 
};

class Parser
{
public:
	Parser() {}
	virtual ~Parser() {}

	virtual void Parse(Scanner& sc, ProgramNodeBuilder&) {}
};

class XBoxCodeGenerator : public CodeGenerator
{
public:
	// IMplement the custom functions in the base class
}

// THis is the facade !!!
class Compiler
{
public:
	Compiler();

	virtual void Compile(istream& input, BytecodeStream& output)
	{
		Scanner scanner(input);
		ProgramNodeBuilder builder;
		Parser parser;
		parser.Parse(scanner, builder);

		XBoxCodeGenerator generator(output);
		ProgramNode* parseTree = builder.GetRootNode();
		parseTree->Traverse(generator);

	}
};


int main()
{

	return 0;
}
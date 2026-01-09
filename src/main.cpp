#include <iostream>
#include <wx/init.h> // wxInitializer
#include <wx/string.h>

int main()
{
	wxInitializer initializer;

	wxString s = "Hello world\n";
	std::cout << s;
}

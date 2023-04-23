

#include <iostream>
#include "Windows.h"

using namespace std;

extern "C" __declspec(dllimport) void LastSymb(char* source, char* out, char* dest);

int main()
{
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);

	char inpStr[256];
	char inpChar;
	char outStr[256];

	cout << "Статическое подключение библиотеки" << endl;
	cout << "Введите строку: ";

	cin.getline(inpStr, 256);
	cout << "Введите букву: ";

	cin >> inpChar;
	LastSymb(inpStr, outStr, &inpChar);

	cout << "Новая строка: ";
	cout << outStr << endl;

	system("pause");
	return 0;
}
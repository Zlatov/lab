#include <iostream>
using namespace std;

int main()
{
	int a = 0;
	while (a <= 20) {
		cout << "a: " << a << endl;
		a = a + 2;
	}

	cout << endl;

	a = 0;
	do {
		a++;
		cout << "a: " << a << endl;
	} while (a < 0);

	return 0;
}

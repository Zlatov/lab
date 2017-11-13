#include <iostream>
using namespace std;

int main()
{
	for (int i = 0; i < 10; ++i) {
		cout << "i: " << i << " ";
	}

	cout << endl;

	int a = 0;
	for (; a < 10; a++) {
		cout << "a: " << a << " ";
	}

	cout << endl;

	for (a--; a >= 0;) {
		cout << "a: " << a << " ";
		a--;
	}

	cout << endl;

	for (; a < 9;) {
		a++;
		cout << "a: " << a << " ";
	}

	cout << endl;

	return 0;
}

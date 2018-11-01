#!/bin/bash
set -eu
# if [[ $A == 'asd' ]]; then
# 	echo "A == 'asd'"
# fi

# A='zx'
# A='zxc'

if [[ -z ${A-} ]]
then
	# if [[ "$A" == 'asd' || "$A" == 'zxc'  ]]; then
	echo "переменная неустановлена"
	# fi
else
	echo "переменная не неустановлена"
fi
# exit 0

if [[ -n ${A-} ]]
then
	echo "переменная установлена"
else
	echo "переменная не установлена"
fi

if [[ ! -z ${A-} ]]
then
	echo "переменная не неустановлена"
	# fi
else
	echo "переменная неустановлена"
fi

if [[ ! -n ${A-} ]]
then
	echo "переменная не установлена"
else
	echo "переменная установлена"
fi

A='zxc'
echo "A='zxc'"

if [[ -z ${A-} ]]
then
	# if [[ "$A" == 'asd' || "$A" == 'zxc'  ]]; then
	echo "переменная неустановлена"
	# fi
else
	echo "переменная не неустановлена"
fi
# exit 0

if [[ -n ${A-} ]]
then
	echo "переменная установлена"
else
	echo "переменная не установлена"
fi

if [[ ! -z ${A-} ]]
then
	echo "переменная не неустановлена"
	# fi
else
	echo "переменная неустановлена"
fi

if [[ ! -n ${A-} ]]
then
	echo "переменная не установлена"
else
	echo "переменная установлена"
fi

if [[ -n ${A-} && ( "$A" == 'asd' || "$A" == 'zxc' )  ]]
then
	echo "asd"
else
	echo "123"
fi

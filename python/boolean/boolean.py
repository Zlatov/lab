# -*- coding: utf-8 -*-

# Данный тип является подтипом целого (int):
print isinstance(True, int)  # True
print isinstance(False, int)  # True
print issubclass(bool, int)  # True

a = True; print a
a = bool(10); print a
a = bool('some'); print a

a = False; print a
a = bool(0); print a
a = bool(''); print a
a = bool(); print a


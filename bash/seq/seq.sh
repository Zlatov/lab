#!/usr/bin/env bash

seq 4               # > 1
                    # > 2
                    # > 3
                    # > 4

seq -s : 4          # > 1:2:3:4

seq 2 4             # > 2
                    # > 3
                    # > 4

seq -s : 2 4        # > 2:3:4

# TODO разобраться с этим:

echo -n "$(seq 4)"  # > 1
                    # > 2
                    # > 3
                    # > 4

echo -n $(seq 4)    # > 1 2 3 4

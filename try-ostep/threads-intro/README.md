
A simple set of programs that use threads:
- `t0.c`
- `t1.c`

Each one depends on header files found in `../include`

The Makefile is simplistic but will do.

## Note

prompt> objdump -d main

gcc -g

gdb valgrind purify

- synchronization primitives
- sleeping / waking interaction

## QA

- What support do we need from the hardware in order to build useful synchronization primitives?
- What support do we need from the OS?
- How can we build these primitives correctly and efficiently?
- How can programs use them to get the desired results?

## homework

1.
./x86.py -p loop.s -t 1 -i 100 -R dx

   dx          Thread 0
    0
    -1  1000 sub  $1,%dx
    -1  1001 test $0,%dx
    -1  1002 jgte .top
    -1  1003 halt

2.
./x86.py -p loop.s -t 2 -i 100 -a dx=3,dx=3 -R dx

   dx          Thread 0                Thread 1
    3
    2   1000 sub  $1,%dx
    2   1001 test $0,%dx
    2   1002 jgte .top
    1   1000 sub  $1,%dx
    1   1001 test $0,%dx
    1   1002 jgte .top
    0   1000 sub  $1,%dx
    0   1001 test $0,%dx
    0   1002 jgte .top
    -1  1000 sub  $1,%dx
    -1  1001 test $0,%dx
    -1  1002 jgte .top
    -1  1003 halt
    3   ----- Halt;Switch -----  ----- Halt;Switch -----
    2                            1000 sub  $1,%dx
    2                            1001 test $0,%dx
    2                            1002 jgte .top
    1                            1000 sub  $1,%dx
    1                            1001 test $0,%dx
    1                            1002 jgte .top
    0                            1000 sub  $1,%dx
    0                            1001 test $0,%dx
    0                            1002 jgte .top
    -1                           1000 sub  $1,%dx
    -1                           1001 test $0,%dx
    -1                           1002 jgte .top
    -1                           1003 halt

3.
./x86.py -p loop.s -t 2 -i 3 -r -a dx=3,dx=3 -R dx
   dx          Thread 0                Thread 1
    3
    2   1000 sub  $1,%dx
    2   1001 test $0,%dx
    2   1002 jgte .top
    3   ------ Interrupt ------  ------ Interrupt ------
    2                            1000 sub  $1,%dx
    2                            1001 test $0,%dx
    2                            1002 jgte .top
    2   ------ Interrupt ------  ------ Interrupt ------
    1   1000 sub  $1,%dx
    1   1001 test $0,%dx
    2   ------ Interrupt ------  ------ Interrupt ------
    1                            1000 sub  $1,%dx
    1   ------ Interrupt ------  ------ Interrupt ------
    1   1002 jgte .top
    0   1000 sub  $1,%dx
    1   ------ Interrupt ------  ------ Interrupt ------
    1                            1001 test $0,%dx
    1                            1002 jgte .top
    0   ------ Interrupt ------  ------ Interrupt ------
    0   1001 test $0,%dx
    0   1002 jgte .top
    -1  1000 sub  $1,%dx
    1   ------ Interrupt ------  ------ Interrupt ------
    0                            1000 sub  $1,%dx
    -1  ------ Interrupt ------  ------ Interrupt ------
    -1  1001 test $0,%dx
    -1  1002 jgte .top
    0   ------ Interrupt ------  ------ Interrupt ------
    0                            1001 test $0,%dx
    0                            1002 jgte .top
    -1  ------ Interrupt ------  ------ Interrupt ------
    -1  1003 halt
    0   ----- Halt;Switch -----  ----- Halt;Switch -----
    -1                           1000 sub  $1,%dx
    -1                           1001 test $0,%dx
    -1  ------ Interrupt ------  ------ Interrupt ------
    -1                           1002 jgte .top
    -1                           1003 halt

./x86.py -p loop.s -t 2 -i 3 -r -s 100 -a dx=3,dx=3 -R dx

4.
./x86.py -p looping-race-nolock.s -t 1 -M 2000

 2000          Thread 0
    0
    0   1000 mov 2000, %ax
    0   1001 add $1, %ax
    1   1002 mov %ax, 2000
    1   1003 sub  $1, %bx
    1   1004 test $0, %bx
    1   1005 jgt .top
    1   1006 halt

5.
./x86.py -p looping-race-nolock.s -t 2 -a bx=3 -M 2000

 2000          Thread 0                Thread 1
    0
    0   1000 mov 2000, %ax
    0   1001 add $1, %ax
    1   1002 mov %ax, 2000
    1   1003 sub  $1, %bx
    1   1004 test $0, %bx
    1   1005 jgt .top
    1   1000 mov 2000, %ax
    1   1001 add $1, %ax
    2   1002 mov %ax, 2000
    2   1003 sub  $1, %bx
    2   1004 test $0, %bx
    2   1005 jgt .top
    2   1000 mov 2000, %ax
    2   1001 add $1, %ax
    3   1002 mov %ax, 2000
    3   1003 sub  $1, %bx
    3   1004 test $0, %bx
    3   1005 jgt .top
    3   1006 halt
    3   ----- Halt;Switch -----  ----- Halt;Switch -----
    3                            1000 mov 2000, %ax
    3                            1001 add $1, %ax
    4                            1002 mov %ax, 2000
    4                            1003 sub  $1, %bx
    4                            1004 test $0, %bx
    4                            1005 jgt .top
    4                            1000 mov 2000, %ax
    4                            1001 add $1, %ax
    5                            1002 mov %ax, 2000
    5                            1003 sub  $1, %bx
    5                            1004 test $0, %bx
    5                            1005 jgt .top
    5                            1000 mov 2000, %ax
    5                            1001 add $1, %ax
    6                            1002 mov %ax, 2000
    6                            1003 sub  $1, %bx
    6                            1004 test $0, %bx
    6                            1005 jgt .top
    6                            1006 halt

6. -s 1, -s 2, etc.
./x86.py -p looping-race-nolock.s -t 2 -M 2000 -i 4 -r -s 1

 2000          Thread 0                Thread 1
    0
    0   1000 mov 2000, %ax
    0   ------ Interrupt ------  ------ Interrupt ------
    0                            1000 mov 2000, %ax
    0                            1001 add $1, %ax
    1                            1002 mov %ax, 2000
    1                            1003 sub  $1, %bx
    1   ------ Interrupt ------  ------ Interrupt ------
    1   1001 add $1, %ax
    1   1002 mov %ax, 2000
    1   1003 sub  $1, %bx
    1   1004 test $0, %bx
    1   ------ Interrupt ------  ------ Interrupt ------
    1                            1004 test $0, %bx
    1                            1005 jgt .top
    1   ------ Interrupt ------  ------ Interrupt ------
    1   1005 jgt .top
    1   1006 halt
    1   ----- Halt;Switch -----  ----- Halt;Switch -----
    1   ------ Interrupt ------  ------ Interrupt ------
    1                            1006 halt

7.
./x86.py -p looping-race-nolock.s -a bx=1 -t 2 -M 2000 -i 1

8.
./x86.py -p looping-race-nolock.s -a bx=100 -t 2 -M 2000 -i 1

9.
./x86.py -p wait-for-me.s -a ax=1,ax=0 -R ax -M 2000

 2000      ax          Thread 0                Thread 1
    0       1
    0       1   1000 test $1, %ax
    0       1   1001 je .signaller
    1       1   1006 mov  $1, 2000
    1       1   1007 halt
    1       0   ----- Halt;Switch -----  ----- Halt;Switch -----
    1       0                            1000 test $1, %ax
    1       0                            1001 je .signaller
    1       0                            1002 mov  2000, %cx
    1       0                            1003 test $1, %cx
    1       0                            1004 jne .waiter
    1       0                            1005 halt

10. # wait until
./x86.py -p wait-for-me.s -a ax=0,ax=1 -R ax -M 2000

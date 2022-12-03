
# Threads API

Some simple examples of how to use POSIX thread APIs.

Relevant files:
- `thread_create.c`: A simple thread creation program, with args passed to the thread.
- `thread_create_with_return_args.c`: Return values from the thread to the parent.
- `thread_create_simple_args.c`: Simpler argument/return value passing for the lazy.

Type `make` to build; each file `foo.c` generates an executable `foo` which you can then run, e.g:

```sh
prompt> ./thread_create
```

## Commond

```sh
seq 10 | xargs -i ./main-signal
```

## Homework

1.

```sh
prompt> valgrind --tool=helgrind ./main-race

==4043780== Possible data race during read of size 4 at 0x11A014 by thread #1
==4043780== Locks held: none
==4043780==    at 0x108F28: main (main-race.c:15)
==4043780==
==4043780== This conflicts with a previous write of size 4 by thread #2
==4043780== Locks held: none
==4043780==    at 0x108ED0: worker (main-race.c:8)
==4043780==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4043780==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4043780==    by 0x4975D1B: thread_start (clone.S:79)
==4043780==  Address 0x11a014 is 0 bytes inside data symbol "balance"
==4043780==
==4043780== ----------------------------------------------------------------
==4043780==
==4043780== Possible data race during write of size 4 at 0x11A014 by thread #1
==4043780== Locks held: none
==4043780==    at 0x108F38: main (main-race.c:15)
==4043780==
==4043780== This conflicts with a previous write of size 4 by thread #2
==4043780== Locks held: none
==4043780==    at 0x108ED0: worker (main-race.c:8)
==4043780==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4043780==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4043780==    by 0x4975D1B: thread_start (clone.S:79)
==4043780==  Address 0x11a014 is 0 bytes inside data symbol "balance"
==4043780== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)
```

2.1. remove one of the offending lines of code?

```sh
==4054164==
==4054164==
==4054164== Use --history-level=approx or =none to gain increased speed, at
==4054164== the cost of reduced accuracy of conflicting-access information
==4054164== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```

2.2. Now add a lock around one of the updates to the shared variable,

```sh
==4065746==
==4065746==  Lock at 0x11A020 was first observed
==4065746==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4065746==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4065746==    by 0x108EC7: worker (main-race.c:9)
==4065746==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4065746==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4065746==    by 0x4975D1B: thread_start (clone.S:79)
==4065746==  Address 0x11a020 is 0 bytes inside data symbol "lock"
==4065746==
==4065746== Possible data race during write of size 4 at 0x11A018 by thread #1
==4065746== Locks held: none
==4065746==    at 0x108F54: main (main-race.c:18)
==4065746==
==4065746== This conflicts with a previous write of size 4 by thread #2
==4065746== Locks held: 1, at address 0x11A020
==4065746==    at 0x108EE0: worker (main-race.c:10)
==4065746==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4065746==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4065746==    by 0x4975D1B: thread_start (clone.S:79)
==4065746==  Address 0x11a018 is 0 bytes inside data symbol "balance"
==4065746==
==4065746==
==4065746== Use --history-level=approx or =none to gain increased speed, at
==4065746== the cost of reduced accuracy of conflicting-access information
==4065746== For lists of detected and suppressed errors, rerun with: -s
==4065746== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)
```

2.3. and then around both.

```sh
==4067822==
==4067822==
==4067822== Use --history-level=approx or =none to gain increased speed, at
==4067822== the cost of reduced accuracy of conflicting-access information
==4067822== For lists of detected and suppressed errors, rerun with: -s
==4067822== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 7 from 6)
```

3. ??

```sh
❯ ./main-deadlock
1 worker
1 lock
0 worker
1 unlock
0 lock
0 unlock
```

4. valgrind --tool=helgrind ./main-deadlock

```sh
==4101652== Thread #3: lock order "0x11A018 before 0x11A048" violated
==4101652==
==4101652== Observed (incorrect) order is: acquisition of lock at 0x11A048
==4101652==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4101652==    by 0x108EEF: worker (main-deadlock.c:15)
==4101652==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4101652==    by 0x4975D1B: thread_start (clone.S:79)
==4101652==
==4101652==  followed by a later acquisition of lock at 0x11A018
==4101652==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4101652==    by 0x108EFB: worker (main-deadlock.c:16)
==4101652==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4101652==    by 0x4975D1B: thread_start (clone.S:79)
==4101652==
==4101652== Required order was established by acquisition of lock at 0x11A018
==4101652==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4101652==    by 0x108ED3: worker (main-deadlock.c:12)
==4101652==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4101652==    by 0x4975D1B: thread_start (clone.S:79)
==4101652==
==4101652==  followed by a later acquisition of lock at 0x11A048
==4101652==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4101652==    by 0x108EDF: worker (main-deadlock.c:13)
==4101652==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4101652==    by 0x4975D1B: thread_start (clone.S:79)
==4101652==
==4101652==  Lock at 0x11A018 was first observed
==4101652==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4101652==    by 0x108ED3: worker (main-deadlock.c:12)
==4101652==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4101652==    by 0x4975D1B: thread_start (clone.S:79)
==4101652==  Address 0x11a018 is 0 bytes inside data symbol "m1"
==4101652==
==4101652==  Lock at 0x11A048 was first observed
==4101652==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4101652==    by 0x108EDF: worker (main-deadlock.c:13)
==4101652==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4101652==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4101652==    by 0x4975D1B: thread_start (clone.S:79)
==4101652==  Address 0x11a048 is 0 bytes inside data symbol "m2"
==4101652==
==4101652==
==4101652==
==4101652== Use --history-level=approx or =none to gain increased speed, at
==4101652== the cost of reduced accuracy of conflicting-access information
==4101652== For lists of detected and suppressed errors, rerun with: -s
==4101652== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 7 from 6)
```

5.

```sh
==4106532==
==4106532== Thread #3: lock order "0x11A048 before 0x11A078" violated
==4106532==
==4106532== Observed (incorrect) order is: acquisition of lock at 0x11A078
==4106532==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4106532==    by 0x108EFB: worker (main-deadlock-global.c:15)
==4106532==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4106532==    by 0x4975D1B: thread_start (clone.S:79)
==4106532==
==4106532==  followed by a later acquisition of lock at 0x11A048
==4106532==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4106532==    by 0x108F07: worker (main-deadlock-global.c:16)
==4106532==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4106532==    by 0x4975D1B: thread_start (clone.S:79)
==4106532==
==4106532== Required order was established by acquisition of lock at 0x11A048
==4106532==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4106532==    by 0x108EDF: worker (main-deadlock-global.c:12)
==4106532==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4106532==    by 0x4975D1B: thread_start (clone.S:79)
==4106532==
==4106532==  followed by a later acquisition of lock at 0x11A078
==4106532==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4106532==    by 0x108EEB: worker (main-deadlock-global.c:13)
==4106532==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4106532==    by 0x4975D1B: thread_start (clone.S:79)
==4106532==
==4106532==  Lock at 0x11A048 was first observed
==4106532==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4106532==    by 0x108EDF: worker (main-deadlock-global.c:12)
==4106532==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4106532==    by 0x4975D1B: thread_start (clone.S:79)
==4106532==  Address 0x11a048 is 0 bytes inside data symbol "m1"
==4106532==
==4106532==  Lock at 0x11A078 was first observed
==4106532==    at 0x486CCC4: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x108C63: Pthread_mutex_lock (mythreads.h:23)
==4106532==    by 0x108EEB: worker (main-deadlock-global.c:13)
==4106532==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4106532==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4106532==    by 0x4975D1B: thread_start (clone.S:79)
==4106532==  Address 0x11a078 is 0 bytes inside data symbol "m2"
==4106532==
==4106532==
==4106532==
==4106532== Use --history-level=approx or =none to gain increased speed, at
==4106532== the cost of reduced accuracy of conflicting-access information
==4106532== For lists of detected and suppressed errors, rerun with: -s
==4106532== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 7 from 6)
```

7.

```sh
==4156252== Possible data race during write of size 4 at 0x11A014 by thread #2
==4156252== Locks held: none
==4156252==    at 0x108F14: worker (main-signal.c:9)
==4156252==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4156252==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4156252==    by 0x4975D1B: thread_start (clone.S:79)
==4156252==
==4156252== This conflicts with a previous read of size 4 by thread #1
==4156252== Locks held: none
==4156252==    at 0x108F70: main (main-signal.c:16)
==4156252==  Address 0x11a014 is 0 bytes inside data symbol "done"
==4156252==
==4156252== ----------------------------------------------------------------
==4156252==
==4156252== Possible data race during read of size 4 at 0x11A014 by thread #1
==4156252== Locks held: none
==4156252==    at 0x108F70: main (main-signal.c:16)
==4156252==
==4156252== This conflicts with a previous write of size 4 by thread #2
==4156252== Locks held: none
==4156252==    at 0x108F14: worker (main-signal.c:9)
==4156252==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4156252==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4156252==    by 0x4975D1B: thread_start (clone.S:79)
==4156252==  Address 0x11a014 is 0 bytes inside data symbol "done"
==4156252==
==4156252== ----------------------------------------------------------------
==4156252==
==4156252== Possible data race during write of size 1 at 0x524A190 by thread #1
==4156252== Locks held: none
==4156252==    at 0x4872FB0: __GI_memcpy (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4156252==    by 0x4905693: _IO_new_file_xsputn (fileops.c:1235)
==4156252==    by 0x4905693: _IO_file_xsputn@@GLIBC_2.17 (fileops.c:1196)
==4156252==    by 0x48FAF4B: puts (ioputs.c:40)
==4156252==    by 0x108F87: main (main-signal.c:18)
==4156252==  Address 0x524a190 is 0 bytes inside a block of size 1,024 alloc'd
==4156252==    at 0x4866E08: malloc (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4156252==    by 0x48F88F3: _IO_file_doallocate (filedoalloc.c:101)
==4156252==    by 0x49071FF: _IO_doallocbuf (genops.c:347)
==4156252==    by 0x49071FF: _IO_doallocbuf (genops.c:342)
==4156252==    by 0x49065C7: _IO_file_overflow@@GLIBC_2.17 (fileops.c:744)
==4156252==    by 0x4905717: _IO_new_file_xsputn (fileops.c:1243)
==4156252==    by 0x4905717: _IO_file_xsputn@@GLIBC_2.17 (fileops.c:1196)
==4156252==    by 0x48FAF4B: puts (ioputs.c:40)
==4156252==    by 0x108F07: worker (main-signal.c:8)
==4156252==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4156252==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4156252==    by 0x4975D1B: thread_start (clone.S:79)
==4156252==  Block was alloc'd by thread #2
==4156252==
==4156252== ----------------------------------------------------------------
==4156252==
==4156252== Possible data race during write of size 1 at 0x524A1A0 by thread #1
==4156252== Locks held: none
==4156252==    at 0x487300C: __GI_memcpy (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4156252==    by 0x4905693: _IO_new_file_xsputn (fileops.c:1235)
==4156252==    by 0x4905693: _IO_file_xsputn@@GLIBC_2.17 (fileops.c:1196)
==4156252==    by 0x48FAF4B: puts (ioputs.c:40)
==4156252==    by 0x108F87: main (main-signal.c:18)
==4156252==  Address 0x524a1a0 is 16 bytes inside a block of size 1,024 alloc'd
==4156252==    at 0x4866E08: malloc (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4156252==    by 0x48F88F3: _IO_file_doallocate (filedoalloc.c:101)
==4156252==    by 0x49071FF: _IO_doallocbuf (genops.c:347)
==4156252==    by 0x49071FF: _IO_doallocbuf (genops.c:342)
==4156252==    by 0x49065C7: _IO_file_overflow@@GLIBC_2.17 (fileops.c:744)
==4156252==    by 0x4905717: _IO_new_file_xsputn (fileops.c:1243)
==4156252==    by 0x4905717: _IO_file_xsputn@@GLIBC_2.17 (fileops.c:1196)
==4156252==    by 0x48FAF4B: puts (ioputs.c:40)
==4156252==    by 0x108F07: worker (main-signal.c:8)
==4156252==    by 0x486F41B: ??? (in /usr/libexec/valgrind/vgpreload_helgrind-arm64-linux.so)
==4156252==    by 0x490D5C7: start_thread (pthread_create.c:442)
==4156252==    by 0x4975D1B: thread_start (clone.S:79)
==4156252==  Block was alloc'd by thread #2
==4156252==
this should print last
==4156252==
==4156252== Use --history-level=approx or =none to gain increased speed, at
==4156252== the cost of reduced accuracy of conflicting-access information
==4156252== For lists of detected and suppressed errors, rerun with: -s
==4156252== ERROR SUMMARY: 24 errors from 4 contexts (suppressed: 42 from 34)
```

9.

```sh
==4166175==
this should print first
this should print last
==4166175==
==4166175== Use --history-level=approx or =none to gain increased speed, at
==4166175== the cost of reduced accuracy of conflicting-access information
==4166175== For lists of detected and suppressed errors, rerun with: -s
==4166175== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 7 from 6)
```

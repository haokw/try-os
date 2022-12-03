CC := gcc
CFLAGS := -g -Wall -Werror -I../include

SRCS := thread_create.c \
	thread_create_simple_args.c \
	thread_create_with_return_args.c

OBJS := ${SRCS:c=o}
PROGS := ${SRCS:.c=}

.PHONY: all
all: ${PROGS}

${PROGS} : % : %.o Makefile
	${CC} $< -o $@ -pthread

clean:
	rm -rf ${PROGS} ${OBJS}

%.o: %.c Makefile
	${CC} ${CFLAGS} -c $<

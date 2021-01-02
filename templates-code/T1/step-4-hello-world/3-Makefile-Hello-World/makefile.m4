__code_license_header_hash_style__

CC      = gcc
SRCS    = main-fixed.c
OBJS    = $(subst .c,.o,$(SRCS))
CFLAGS  = -Wall -Werror -Wextra
RM      = rm -f

all: main
debug: $(eval CFLAGS := -g -DDBUG)
debug: main

main: $(OBJS)
	$(CC) -o main $(OBJS) $(CFLAGS)

main.o: main-fixed.c

# We don't glob because this doesn't scale for
# large projects
# %.o: %.c $(DEPS)
# 	$(CC) -g -c -o $@ $< $(CFLAGS)

clean:
	$(RM) $(OBJS) main

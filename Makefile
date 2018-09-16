.POSIX:
.SUFFIXES:

TARGET   = libtest.a
BUILDDIR = build
CC       = clang
CFLAGS   = -std=c17 -pedantic-errors -g -Weverything
AR       = ar
ARFLAGS  = rcs

###############################################################################
# General Commands

all: $(BUILDDIR)/$(TARGET)

include src/build.mk
include tests/build.mk

clean:
	rm -rf $(BUILDDIR) src/*.o src/*.d tests/*.o tests/*.d $(test_apps)

test: run_tests

###############################################################################
# Private Stuff

builddir = $(BUILDDIR)/.empty

$(builddir):
	mkdir $(BUILDDIR)
	touch $@

###############################################################################
# Library

-include src/*.d

.SUFFIXES: .c .o
.c.o:
	$(CC) $(CFLAGS) -c -MMD -I include -o $@ $<

$(BUILDDIR)/$(TARGET): $(builddir) $(objects)
	$(AR) $(ARFLAGS) -o $@ $(objects)

###############################################################################
# Tests

$(test_apps): $(BUILDDIR)/$(TARGET)

.SUFFIXES: .o
.o:
	$(CC) $(CFLAGS) -I include -o $@ $< $(BUILDDIR)/$(TARGET)

.POSIX:
.SUFFIXES:

DESTDIR  =
PREFIX   = /usr/local
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

install: $(BUILDDIR)/$(TARGET)
	mkdir -p $(DESTDIR)$(PREFIX)/include $(DESTDIR)$(PREFIX)/lib
	cp -r include/libtest $(DESTDIR)$(PREFIX)/include
	cp $(BUILDDIR)/$(TARGET) $(DESTDIR)$(PREFIX)/lib

uninstall:
	rm -rf $(DESTDIR)$(PREFIX)/include/libtest
	rm -rf $(DESTDIR)$(PREFIX)/lib/$(TARGET)

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

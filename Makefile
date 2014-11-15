CFLAGS=-O2 -g -Wall -W `pkg-config --cflags librtlsdr`
LIBS=`pkg-config --libs librtlsdr` -lpthread -lm
CC=gcc

PREFIX=/usr/local

all: dump1090

%.o: %.c
	$(CC) $(CFLAGS) -c -DWEB_DIR=\"$(PREFIX)/share/dump1090\" $<

dump1090: dump1090.o anet.o
	$(CC) -g -o dump1090 dump1090.o anet.o $(LIBS)

clean:
	rm -f *.o dump1090

install: dump1090
	install -m 0755 -d $(PREFIX)/share/dump1090

	install -m 0755 -t $(PREFIX)/bin dump1090
	install -m 0644 -t $(PREFIX)/share/dump1090 gmap.html

.PHONY: install
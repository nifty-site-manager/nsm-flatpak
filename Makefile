#basic makefile for nsm-flatpak
objects=nsm.o DateTimeInfo.o Directory.o Filename.o PageBuilder.o PageInfo.o Path.o Quoted.o SiteInfo.o Title.o
cppfiles=nsm.cpp DateTimeInfo.cpp Directory.cpp Filename.cpp PageBuilder.cpp PageInfo.cpp Path.cpp Quoted.cpp SiteInfo.cpp Title.cpp
CC=g++
LINK=-pthread
CXXFLAGS=-std=c++11 -Wall -Wextra -pedantic -O3

prefix=/app
datadir=share

nsm: $(objects)
	$(CC) $(CXXFLAGS) $(cppfiles) -o nsm $(LINK)
	$(CC) $(CXXFLAGS) $(cppfiles) -o nift $(LINK)

nsm.o: nsm.cpp SiteInfo.o
	$(CC) $(CXXFLAGS) -c -o $@ $< $(LINK)

SiteInfo.o: SiteInfo.cpp SiteInfo.h PageBuilder.o
	$(CC) $(CXXFLAGS) -c -o $@ $< $(LINK)

PageBuilder.o: PageBuilder.cpp PageBuilder.h DateTimeInfo.o PageInfo.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

DateTimeInfo.o: DateTimeInfo.cpp DateTimeInfo.h
	$(CC) $(CXXFLAGS) -c -o $@ $<

PageInfo.o: PageInfo.cpp PageInfo.h Path.o Title.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

Path.o: Path.cpp Path.h Directory.o Filename.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

Directory.o: Directory.cpp Directory.h Quoted.h
	$(CC) $(CXXFLAGS) -c -o $@ $<

Filename.o: Filename.cpp Filename.h Quoted.h
	$(CC) $(CXXFLAGS) -c -o $@ $<

Title.o: Title.cpp Title.h Quoted.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

Quoted.o: Quoted.cpp Quoted.h
	$(CC) $(CXXFLAGS) -c -o $@ $<

install:
	install -D nsm /app/bin/nsm
	install -D nsm /app/bin/nift
	install -Dm644 cc.nift.nsm.appdata.xml $(prefix)/$(datadir)/appdata/cc.nift.nsm.appdata.xml
	install -Dm644 cc.nift.nsm.desktop $(prefix)/$(datadir)/desktop/cc.nift.nsm.desktop
	install -Dm644 cc.nift.nsm64.png $(prefix)/$(datadir)/icons/hicolor/64x64/apps/cc.nift.nsm.png
	install -Dm644 cc.nift.nsm128.png $(prefix)/$(datadir)/icons/hicolor/128x128/apps/cc.nift.nsm.png
	install -Dm644 cc.nift.nsm256.png $(prefix)/$(datadir)/icons/hicolor/256x256/apps/cc.nift.nsm.png
	install -Dm644 cc.nift.nsm512.png $(prefix)/$(datadir)/icons/hicolor/512x512/apps/cc.nift.nsm.png

uninstall:
	rm /app/bin/nsm
	rm /app/bin/nift

clean:
	rm -f $(objects)

clean-all:
	rm -f $(objects) nsm


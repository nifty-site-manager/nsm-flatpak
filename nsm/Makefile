#basic makefile for nsm-flatpak
objects=nsm.o DateTimeInfo.o Directory.o Filename.o PageBuilder.o PageInfo.o Path.o Quoted.o SiteInfo.o Title.o
cppfiles=nsm.cpp DateTimeInfo.cpp Directory.cpp Filename.cpp PageBuilder.cpp PageInfo.cpp Path.cpp Quoted.cpp SiteInfo.cpp Title.cpp
CC=g++
CXXFLAGS=-std=c++11 -Wall -Wextra -pedantic

prefix=/app
datadir=share

nsm: $(objects)
	$(CC) $(CXXFLAGS) $(cppfiles) -o nsm

nsm.o: nsm.cpp SiteInfo.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

SiteInfo.o: SiteInfo.cpp SiteInfo.h PageBuilder.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

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
	install -Dm644 org.nifty-site-manager.nsm.appdata.xml $(prefix)/$(datadir)/appdata/org.nifty-site-manager.nsm.appdata.xml
	install -Dm644 org.nifty-site-manager.nsm.desktop $(prefix)/$(prefix)/desktop/org.nifty-site-manager.nsm.desktop
	install -Dm644 org.nifty-site-manager.nsm64.png $(prefix)/$(prefix)/icons/hicolor/64x64/apps/org.nifty-site-manager.nsm.png
	install -Dm644 org.nifty-site-manager.nsm128.png $(prefix)/$(prefix)/icons/hicolor/128x128/apps/org.nifty-site-manager.nsm.png
	install -Dm644 org.nifty-site-manager.nsm256.png $(prefix)/$(prefix)/icons/hicolor/256x256/apps/org.nifty-site-manager.nsm.png
	install -Dm644 org.nifty-site-manager.nsm512.png $(prefix)/$(prefix)/icons/hicolor/512x512/apps/org.nifty-site-manager.nsm.png

uninstall:
	rm /app/bin/nsm

clean:
	rm -f $(objects)

clean-all:
	rm -f $(objects) nsm


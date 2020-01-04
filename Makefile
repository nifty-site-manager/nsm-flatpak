#basic makefile for nsm-flatpak
objects=nsm.o DateTimeInfo.o Directory.o Filename.o FileSystem.o GitInfo.o Parser.o Path.o ProjectInfo.o Quoted.o Title.o TrackedInfo.o WatchList.o
cppfiles=nsm.cpp DateTimeInfo.cpp Directory.cpp Filename.cpp FileSystem.cpp GitInfo.cpp Parser.cpp Path.cpp ProjectInfo.cpp Quoted.cpp Title.cpp TrackedInfo.cpp WatchList.cpp
CC=g++
LINK=-pthread
CXXFLAGS=-std=c++11 -Wall -Wextra -pedantic -O3

prefix=/app
datadir=share

nsm: $(objects)
	$(CXX) $(CXXFLAGS) $(objects) -o nsm $(LINK)
	$(CXX) $(CXXFLAGS) $(objects) -o nift $(LINK)

nsm.o: nsm.cpp GitInfo.o ProjectInfo.o Timer.h
	$(CXX) $(CXXFLAGS) -c -o $@ $< $(LINK)

ProjectInfo.o: ProjectInfo.cpp ProjectInfo.h GitInfo.o Parser.o WatchList.o
	$(CXX) $(CXXFLAGS) -c -o $@ $< $(LINK)

GitInfo.o: GitInfo.cpp GitInfo.h FileSystem.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Parser.o: Parser.cpp Parser.h DateTimeInfo.o FileSystem.o TrackedInfo.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

WatchList.o: WatchList.cpp WatchList.h FileSystem.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

FileSystem.o: FileSystem.cpp FileSystem.h Path.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

DateTimeInfo.o: DateTimeInfo.cpp DateTimeInfo.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

TrackedInfo.o: TrackedInfo.cpp TrackedInfo.h Path.o Title.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Path.o: Path.cpp Path.h Directory.o Filename.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Directory.o: Directory.cpp Directory.h Quoted.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Filename.o: Filename.cpp Filename.h Quoted.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Title.o: Title.cpp Title.h Quoted.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Quoted.o: Quoted.cpp Quoted.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

install:
	install -D nsm /app/bin/nsm
	install -Dm644 cc.nift.nsm.appdata.xml $(prefix)/$(datadir)/appdata/cc.nift.nsm.appdata.xml
	install -Dm644 cc.nift.nsm.desktop $(prefix)/$(datadir)/desktop/cc.nift.nsm.desktop
	install -Dm644 cc.nift.nsm64.png $(prefix)/$(datadir)/icons/hicolor/64x64/apps/cc.nift.nsm.png
	install -Dm644 cc.nift.nsm128.png $(prefix)/$(datadir)/icons/hicolor/128x128/apps/cc.nift.nsm.png
	install -Dm644 cc.nift.nsm256.png $(prefix)/$(datadir)/icons/hicolor/256x256/apps/cc.nift.nsm.png
	install -Dm644 cc.nift.nsm512.png $(prefix)/$(datadir)/icons/hicolor/512x512/apps/cc.nift.nsm.png

uninstall:
	rm /app/bin/nsm

clean:
	rm -f $(objects)

clean-all:
	rm -f $(objects) nsm


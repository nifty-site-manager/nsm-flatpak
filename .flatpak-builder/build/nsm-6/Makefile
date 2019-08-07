#basic makefile for nsm-flatpak
objects=nsm.o DateTimeInfo.o Directory.o Filename.o PageBuilder.o PageInfo.o Path.o Quoted.o SiteInfo.o Title.o
cppfiles=nsm.cpp DateTimeInfo.cpp Directory.cpp Filename.cpp PageBuilder.cpp PageInfo.cpp Path.cpp Quoted.cpp SiteInfo.cpp Title.cpp
CC=g++
CXXFLAGS=-std=c++11 -Wall -Wextra -pedantic

nsm: $(objects)
	$(CC) $(CXXFLAGS) $(cppfiles) -o nsm

nsm.o: SiteInfo.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

SiteInfo.o: PageBuilder.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

PageBuilder.o: DateTimeInfo.o PageInfo.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

DateTimeInfo.o: 
	$(CC) $(CXXFLAGS) -c -o $@ $<

PageInfo.o: Path.o Title.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

Path.o: Directory.o Filename.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

Directory.o: 
	$(CC) $(CXXFLAGS) -c -o $@ $<

Filename.o: 
	$(CC) $(CXXFLAGS) -c -o $@ $<

Title.o: Quoted.o
	$(CC) $(CXXFLAGS) -c -o $@ $<

Quoted.o:
	$(CC) $(CXXFLAGS) -c -o $@ $<

install:
	chmod 755 nsm
	mv nsm /usr/local/bin

uninstall:
	rm /usr/local/bin/nsm

clean:
	rm -f $(objects)

clean-all:
	rm -f $(objects) nsm


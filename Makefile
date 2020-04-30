#basic makefile for nsm-flatpak
objects=nsm.o ConsoleColor.o DateTimeInfo.o Directory.o Expr.o ExprtkFns.o Filename.o FileSystem.o Getline.o GitInfo.o HashTk.o Lolcat.o LuaFns.o Lua.o NumFns.o Pagination.o Parser.o Path.o ProjectInfo.o Quoted.o StrFns.o SystemInfo.o Title.o TrackedInfo.o Variables.o WatchList.o
cppfiles=nsm.cpp ConsoleColor.cpp DateTimeInfo.cpp Directory.cpp Expr.cpp ExprtkFns.cpp Filename.cpp FileSystem.cpp Getline.cpp GitInfo.cpp hashtk/HashTk.cpp Lolcat.cpp LuaFns.cpp Lua.cpp NumFns.cpp Pagination.cpp Parser.cpp Path.cpp ProjectInfo.cpp Quoted.cpp StrFns.cpp SystemInfo.cpp Title.cpp TrackedInfo.cpp Variables.cpp WatchList.cpp

CXX?=g++
CXXFLAGS=-std=c++11 -Wall -Wextra -pedantic -O3 -s
LINK=-pthread ./LuaJIT/src/libluajit.a -ldl

prefix=/app
datadir=share

BINDIR=${prefix}/bin
INCDIR=${prefix}/include
LIBDIR=${prefix}/lib

###

all: make-luajit nsm

###

make-luajit:
	cd LuaJIT && make

###

HashTk.o: hashtk/HashTk.cpp hashtk/HashTk.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

###

nsm: $(objects)
	$(CXX) $(CXXFLAGS) $(objects) -o nsm $(LINK)

nsm.o: nsm.cpp GitInfo.o ProjectInfo.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

ProjectInfo.o: ProjectInfo.cpp ProjectInfo.h GitInfo.o Parser.o WatchList.o Timer.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

GitInfo.o: GitInfo.cpp GitInfo.h ConsoleColor.o FileSystem.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Parser.o: Parser.cpp Parser.h DateTimeInfo.o Expr.o ExprtkFns.o Getline.o HashTk.o LuaFns.o Lua.o Pagination.o SystemInfo.o TrackedInfo.o Variables.o 
	$(CXX) $(CXXFLAGS) -c -o $@ $<

WatchList.o: WatchList.cpp WatchList.h FileSystem.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Getline.o: Getline.cpp Getline.h ConsoleColor.o FileSystem.o Lolcat.o StrFns.o Consts.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Lolcat.o: Lolcat.cpp Lolcat.h FileSystem.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

LuaFns.o: LuaFns.cpp LuaFns.h Lua.o ConsoleColor.o ExprtkFns.o FileSystem.o Path.o Quoted.o Variables.o Consts.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Lua.o: Lua.cpp Lua.h StrFns.o LuaJIT/src/lua.hpp Lua-5.3/src/lua.hpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

ExprtkFns.o: ExprtkFns.cpp ExprtkFns.h Expr.o FileSystem.o Quoted.o Variables.o Consts.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Expr.o: Expr.cpp Expr.h exprtk/exprtk.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

FileSystem.o: FileSystem.cpp FileSystem.h Path.o SystemInfo.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Pagination.o: Pagination.cpp Pagination.h Path.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

DateTimeInfo.o: DateTimeInfo.cpp DateTimeInfo.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

TrackedInfo.o: TrackedInfo.cpp TrackedInfo.h Path.o Title.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Variables.o: Variables.cpp Variables.h NumFns.o Path.o StrFns.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

NumFns.o: NumFns.cpp NumFns.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Path.o: Path.cpp Path.h ConsoleColor.o Directory.o Filename.o SystemInfo.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

StrFns.o: StrFns.cpp StrFns.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Directory.o: Directory.cpp Directory.h Quoted.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Filename.o: Filename.cpp Filename.h Quoted.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

SystemInfo.o: SystemInfo.cpp SystemInfo.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Title.o: Title.cpp Title.h ConsoleColor.o Quoted.o
	$(CXX) $(CXXFLAGS) -c -o $@ $<

ConsoleColor.o: ConsoleColor.cpp ConsoleColor.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

Quoted.o: Quoted.cpp Quoted.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

###

install:
	mkdir /app/include
	install -D LuaJIT/src/lauxlib.h ${INCDIR}/lauxlib.h
	install -D LuaJIT/src/lua.h ${INCDIR}/lua.h
	install -D LuaJIT/src/lua.hpp ${INCDIR}/lua.hpp
	install -D LuaJIT/src/luaconf.h ${INCDIR}/luaconf.h
	install -D LuaJIT/src/lualib.h ${INCDIR}/lualib.h

	install -D LuaJIT/src/luajit ${BINDIR}/luajit

	install -D nsm ${BINDIR}/nsm
	
	install -Dm644 cc.nift.nsm.appdata.xml $(prefix)/$(datadir)/appdata/cc.nift.nsm.appdata.xml
	install -Dm644 cc.nift.nsm.desktop $(prefix)/$(datadir)/desktop/cc.nift.nsm.desktop
	install -Dm644 cc.nift.nsm64.png $(prefix)/$(datadir)/icons/hicolor/64x64/apps/cc.nift.nsm.png
	install -Dm644 cc.nift.nsm128.png $(prefix)/$(datadir)/icons/hicolor/128x128/apps/cc.nift.nsm.png
	install -Dm644 cc.nift.nsm256.png $(prefix)/$(datadir)/icons/hicolor/256x256/apps/cc.nift.nsm.png
	install -Dm644 cc.nift.nsm512.png $(prefix)/$(datadir)/icons/hicolor/512x512/apps/cc.nift.nsm.png

uninstall:
	rm ${INCDIR}/lauxlib.h
	rm ${INCDIR}/lua.h
	rm ${INCDIR}/lua.hpp
	rm ${INCDIR}/luaconf.h
	rm ${INCDIR}/lualib.h

	rm ${BINDIR}/luajit

	rm ${BINDIR}/nsm

	rm $(prefix)/$(datadir)/appdata/cc.nift.nsm.appdata.xml
	rm $(prefix)/$(datadir)/desktop/cc.nift.nsm.desktop
	rm $(prefix)/$(datadir)/icons/hicolor/64x64/apps/cc.nift.nsm.png
	rm $(prefix)/$(datadir)/icons/hicolor/128x128/apps/cc.nift.nsm.png
	rm $(prefix)/$(datadir)/icons/hicolor/256x256/apps/cc.nift.nsm.png
	rm $(prefix)/$(datadir)/icons/hicolor/512x512/apps/cc.nift.nsm.png

clean:
	rm -f $(objects) exprtk.o
	cd LuaJIT && make clean

clean-all:
	rm -f $(objects) exprtk.o nsm
	cd LuaJIT && make clean

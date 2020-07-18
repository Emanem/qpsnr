#Makefile generated by amake
#On Sat Jul 18 18:08:10 2020
#To print amake help use 'amake --help'.
CC=gcc
CPPC=g++
LINK=g++
SRCDIR=src
OBJDIR=obj
FLAGS=-g -Wall -std=c++11 -pthread 
LIBS=-lavcodec -lavformat -lavutil -lswscale 
OBJS=$(OBJDIR)/stats.o $(OBJDIR)/settings.o $(OBJDIR)/main.o $(OBJDIR)/qav.o 
EXEC=qpsnr
DATE=$(shell date +"%Y-%m-%d")

$(EXEC) : $(OBJS)
	$(LINK) $(OBJS) -o $(EXEC) $(FLAGS) $(LIBS)

$(OBJDIR)/stats.o: src/stats.cpp src/stats.h src/mt.h src/settings.h $(OBJDIR)/__setup_obj_dir
	$(CPPC) $(FLAGS) src/stats.cpp -c -o $@

$(OBJDIR)/settings.o: src/settings.cpp src/settings.h $(OBJDIR)/__setup_obj_dir
	$(CPPC) $(FLAGS) src/settings.cpp -c -o $@

$(OBJDIR)/main.o: src/main.cpp src/mt.h src/qav.h src/settings.h src/stats.h $(OBJDIR)/__setup_obj_dir
	$(CPPC) $(FLAGS) src/main.cpp -c -o $@

$(OBJDIR)/qav.o: src/qav.cpp src/qav.h src/settings.h $(OBJDIR)/__setup_obj_dir
	$(CPPC) $(FLAGS) src/qav.cpp -c -o $@

$(OBJDIR)/__setup_obj_dir :
	mkdir -p $(OBJDIR)
	touch $(OBJDIR)/__setup_obj_dir

.PHONY: clean bzip release

clean :
	rm -rf $(OBJDIR)/*.o
	rm -rf $(EXEC)

bzip :
	tar -cvf "$(DATE).$(EXEC).tar" $(SRCDIR)/* Makefile
	bzip2 "$(DATE).$(EXEC).tar"

release : FLAGS +=-O3 -D_RELEASE
release : $(EXEC)


CXX = g++
CXXEXTFLAGS = -O3
CXXFLAGS = -std=c++17 -fopenmp $(CXXEXTFLAGS)
SRCDIR = src
SRCS = $(shell find $(SRCDIR) -name '*.cpp')
INCDIR = include
INCLUDEDIR = $(INCDIR:%=-I%)
OBJDIR = obj
OBJS = $(subst $(SRCDIR),$(OBJDIR),$(SRCS))
OBJS:= $(subst .cpp,.o,$(OBJS))
TARGET = main

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $(INCLUDEDIR) $^ -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	[ -d $(OBJDIR) ] || mkdir $(OBJDIR)
	$(CXX) $(CXXFLAGS) $(INCLUDEDIR) $< -c -o $@

clean:
	rm -f $(OBJDIR)/*.o
	rm -f $(OBJS)
	rm -f $(TARGET)

cleantarget:
	rm -f $(TARGET)

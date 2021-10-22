CXX = g++
CXXEXTFLAGS = -O3
CXXFLAGS = -std=c++17 -fopenmp $(CXXEXTFLAGS)
NVCC = nvcc
NVCCEXTFLAGS = -O3
NVCCFLAGS = -arch=sm_75 $(NVCCEXTFLAGS) -std=c++17 -Xcompiler -fopenmp --compiler-bindir=$(CXX)
SRCDIR = src
SRCS = $(shell find $(SRCDIR) -name '*.cu' -o -name '*.cpp')
INCDIR = include
INCLUDEDIR = $(INCDIR:%=-I%)
OBJDIR = obj
OBJS = $(subst $(SRCDIR),$(OBJDIR),$(SRCS))
OBJS:= $(subst .cpp,.o,$(OBJS))
OBJS:= $(subst .cu,.o,$(OBJS))
TARGET = main

$(TARGET): $(OBJS)
	$(NVCC) $(NVCCFLAGS) $(INCLUDEDIR) $^ -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.cu
	$(NVCC) $(NVCCFLAGS) $(INCLUDEDIR) -c $< -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	[ -d $(OBJDIR) ] || mkdir $(OBJDIR)
	$(CXX) $(CXXFLAGS) $(INCLUDEDIR) $< -c -o $@

clean:
	rm -f $(OBJDIR)/*.o
	rm -f $(OBJS)
	rm -f $(TARGET)

cleantarget:
	rm -f $(TARGET)

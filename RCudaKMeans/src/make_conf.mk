#**********************************************************
R_HOME := $(shell R RHOME)
R_INC := $(R_HOME)/include
R_LIB := $(R_HOME)/lib

# replace these three lines with
CUDA_HOME := /usr/local/cuda-7.0/
#**********************************************************

ifndef CUDA_HOME
    CUDA_HOME := /usr/local/cuda
endif

# set CUDA_INC to CUDA header dir on your system
CUDA_INC := $(CUDA_HOME)/include

ARCH := $(shell uname -m)

# replace these five lines with
ifeq ($(ARCH), i386)
    CUDA_LIB := $(CUDA_HOME)/lib
else
    CUDA_LIB := $(CUDA_HOME)/lib64
endif

OS := $(shell uname -s)

ifeq ($(OS), Darwin)
    ifeq ($(ARCH), x86_64)
        DEVICEOPTS := -m64
    endif

    CUDA_LIB := $(CUDA_HOME)/lib
    R_FRAMEWORK := -F$(R_HOME)/.. -framework R
    RPATH := -rpath $(CUDA_LIB)
    
endif

CPICFLAGS := $(shell R CMD config CPICFLAGS)

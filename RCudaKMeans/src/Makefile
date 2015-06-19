# NEED : export LD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-7.0/lib

include make_conf.mk

LIB_NAME = RCudaKMeans

CC = clang++ -m64
CC_FLAGS = -std=c++11 -fPIC

CUDA_CC = $(CUDA_HOME)/bin/nvcc
CUDA_CC_FLAGS = -std=c++11 -Xcompiler -fPIC  

#CUR_DIR = $(shell pwd)
LIB_DIR = .
OBJ_DIR = .
SRC_DIR = .
INC_DIR = .

DYN_LIB_NAME = $(LIB_NAME).so

# Use all .cpp files in SRC_DIR folder.
CPP_FILES := $(wildcard $(SRC_DIR)/*.cpp)

CUDA_FILES := $(wildcard $(SRC_DIR)/*.cu)

# All object file are gonna be in OBJ_DIR folder.
OBJ_FILES := $(addprefix $(OBJ_DIR)/,$(notdir $(CPP_FILES:.cpp=.o)))
CU_OBJ_FILES := $(addprefix $(OBJ_DIR)/,$(notdir $(CUDA_FILES:.cu=.o)))

R_SRC_INCLUDE = -I$(R_INC)
LD_INCLUDE = -L$(R_LIB)
LD_FLAGS = -shared 
LD_LIB = -lR

INCLUDE_SRC = -I$(INC_DIR) $(R_SRC_INCLUDE) -I/usr/local/include #-I/usr/local/include/freetype2 -I/opt/X11/include

CUDA_LINK = -L$(CUDA_LIB) -lcudart
CUDA_INCLUDE = -I$(CUDA_INC)

all: createDir $(OBJ_FILES) $(CU_OBJ_FILES)
	$(CC) $(LD_FLAGS) $(LD_INCLUDE) $(CUDA_LINK) $(OBJ_FILES) $(CU_OBJ_FILES) $(LD_LIB) -o $(LIB_DIR)/$(DYN_LIB_NAME)

createDir:
	@mkdir -p build lib

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CC) $(CC_FLAGS) $(INCLUDE_SRC) -c -o $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cu
	$(CUDA_CC) $(CUDA_CC_FLAGS) $(INCLUDE_SRC) $(CUDA_INCLUDE) -c -o $@ $<

test:
	@R --slave -f main.R

clean: 
	rm -f $(OBJ_FILES)
	rm -f $(CU_OBJ_FILES)
	rm -f $(LIB_DIR)/$(DYN_LIB_NAME)

CXX	:= g++
CC	:= gcc
RM	:= rm -f

PREFIX			:= /usr/local
HEADER_PATH		:= $(PREFIX)/include
DYLIB_PATH		:= $(PREFIX)/lib

KOI_DIR		:= $(DYLIB_PATH)/Koi
BIN_DIR		:= bin
SRC_DIR 	:= src
OBJ_DIR 	:= obj
LIB_DIR		:= lib

DIRS 					:= $(BIN_DIR) $(SRC_DIR) $(OBJ_DIR)



AUDIO					:= libkoi-audio.dylib
GRAPHICS				:= libkoi-graphics.dylib
NETWORKING				:= libkoi-networking.dylib

AUDIO_SRC				:= $(wildcard $(SRC_DIR)/Audio/*.cpp)
GRAPHICS_SRC			:= $(wildcard $(SRC_DIR)/Graphics/*.cpp)
NETWORKING_SRC			:= $(wildcard $(SRC_DIR)/Networking/*.cpp)

AUDIO_OBJ				:= $(patsubst $(SRC_DIR)/Audio/%.cpp,obj/%.o, $(AUDIO_SRC))
GRAPHICS_OBJ			:= $(patsubst $(SRC_DIR)/Graphics/%.cpp,obj/%.o, $(GRAPHICS_SRC))
NETWORKING_OBJ			:= $(patsubst $(SRC_DIR)/Networking/%.cpp,obj/%.o, $(NETWORKING_SRC))


LIBS_SRC				:= $(wildcard $(LIB_DIR)/*.cpp) $(wildcard $(LIB_DIR)/*.c)
LIBS_OBJ				:= $(patsubst $(LIB_DIR)/%.c,$(OBJ_DIR)/%.o,$(LIBS_SRC))



CPPFLAGS 		:= -Iinclude -MMD -MP
CFLAGS 			:= -Wall
LDFLAGS  		:= -Llib
LDLIBS   		:= -lm
OPENGL			:= -framework OpenGL


.PHONY: all install clean uninstall
all: $(DIRS) $(BIN_DIR)/$(GRAPHICS)#$(BIN_DIR)/$(AUDIO)  $(BIN_DIR)/$(NETWORKING)

install: $(DIRS) $(KOI_DIR) $(LIBS_OBJ) $(KOI_DIR)/$(GRAPHICS)#$(KOI_DIR)/$(AUDIO)  $(KOI_DIR)/$(NETWORKING)

uninstall:
	$(RM) -rv $(KOI_DIR)

clean:
	$(RM) -rv $(BIN_DIR) $(OBJ_DIR)



%/libkoi-audio.dylib: $(AUDIO_OBJ)
	$(CXX) -dynamiclib -o $@ $^
	
%/libkoi-graphics.dylib: $(GRAPHICS_OBJ) $(LIBS_OBJ)
	$(CXX) -dynamiclib -o $@ $^ $(LDLIBS) $(OPENGL)
	
%/libkoi-networking.dylib: $(NETWORKING_OBJ)
	$(CXX) -dynamiclib -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/Audio/%.cpp
	$(CXX) -Iinclude/Audio -c -o $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/Graphics/%.cpp
	$(CXX) -Iinclude/Graphics -c -o $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/Networking/%.cpp
	$(CXX) -Iinclude/Networking -c -o $@ $<
	
	

	
$(LIBS_OBJ): $(LIBS_SRC)
	$(CXX) -c -o $@ $<
	
	
$(DIRS):
	mkdir -p $(DIRS)

$(KOI_DIR):
	mkdir -p $@


CC 				:= g++
RM 				:= rm -f


#PREFIX			= /usr/local
HEADER_PATH		= $(prefix)/include

BIN_DIR 		:= bin
SRC_DIR 		:= src
OBJ_DIR 		:= obj
LIB_DIR			:= lib

DIRS 			:= $(BIN_DIR) $(SRC_DIR) $(OBJ_DIR)

AUDIO			:= libkoi-audio.dylib
GRAPHICS		:= libkoi-graphics.dylib
NETWORKING		:= libkoi-networking.dylib

AUDIO_DIR 		:= $(BIN_DIR)/$(AUDIO)
GRAPHICS_DIR 	:= $(BIN_DIR)/$(GRAPHICS)
NETWORKING_DIR	:= $(BIN_DIR)/$(NETWORKING)

AUDIO_SRC		:= $(wildcard $(SRC_DIR)/Audio/*.cpp)
GRAPHICS_SRC	:= $(wildcard $(SRC_DIR)/Graphics/*.cpp)
NETWORKING_SRC	:= $(wildcard $(SRC_DIR)/Networking/*.cpp)

AUDIO_OBJ		:= $(patsubst $(SRC_DIR)/Audio/%.cpp,obj/%.o, $(AUDIO_SRC))
GRAPHICS_OBJ	:= $(patsubst $(SRC_DIR)/Graphics/%.cpp,obj/%.o, $(GRAPHICS_SRC))
NETWORKING_OBJ	:= $(patsubst $(SRC_DIR)/Networking/%.cpp,obj/%.o, $(NETWORKING_SRC))


LIBS			:= $(LIB_DIR)/glad.c



CPPFLAGS 		:= -Iinclude -MMD -MP
CFLAGS 			:= -Wall
LDFLAGS  		:= -Llib
LDLIBS   		:= -lm
OPENGL			:= -framework OpenGL


.PHONY: all clean
all: $(DIRS) $(AUDIO) $(GRAPHICS) $(NETWORKING)

install: $(DIRS)
	

$(AUDIO): $(AUDIO_DIR)
$(GRAPHICS): $(GRAPHICS_DIR)
$(NETWORKING): $(NETWORKING_DIR)

$(AUDIO_DIR): $(DIRS) $(AUDIO_OBJ)
	g++ -dynamiclib -o $(AUDIO_DIR) $(AUDIO_OBJ)


$(GRAPHICS_DIR): $(DIRS) $(GRAPHICS_OBJ) $(OBJ_DIR)/glad.o
	g++ -dynamiclib -o $(GRAPHICS_DIR) $(GRAPHICS_OBJ) $(OBJ_DIR)/glad.o $(LDLIBS) $(OPENGL)


$(NETWORKING_DIR): $(DIRS) $(NETWORKING_OBJ)
	g++ -dynamiclib -o $(NETWORKING_DIR) $(NETWORKING_OBJ)



$(OBJ_DIR)/%.o: $(SRC_DIR)/Audio/%.cpp
	g++ -Iinclude/Audio -c -o $@ $<


$(OBJ_DIR)/%.o: $(SRC_DIR)/Graphics/%.cpp
	g++ -Iinclude/Graphics -c -o $@ $<


$(OBJ_DIR)/%.o: $(SRC_DIR)/Networking/%.cpp
	g++ -Iinclude/Networking -c -o $@ $<


$(OBJ_DIR)/%.o: $(LIB_DIR)/%.c
	gcc -c -o $@ $<


$(DIRS):
	mkdir -p $(DIRS)



clean:
	$(RM) -rv $(BIN_DIR) $(OBJ_DIR)

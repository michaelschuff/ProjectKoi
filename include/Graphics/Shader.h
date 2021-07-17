//
//  Shader.h
//  ProjectKoi
//
//  Created by Michael Schuff on 7/12/21.
//

#ifndef Shader_h
#define Shader_h

#include <stdio.h>
#include <fstream>
#include <sstream>
#include <iostream>
#include <glad/glad.h>


namespace koi {

class Shader {
public:
    // the program ID
    unsigned int ID;
    
    // constructor reads from a file and builds the shader
    Shader();
    Shader(const char* vertexPath, const char* fragmentPath);
    
    // load shader
    void load(const char* vertexPath, const char* fragmentPath);
    
    // use/activate the shader
    void use();
    
    // utility uniform functions
    void setBool(const std::string &name, bool value) const;
    void setInt(const std::string &name, int value) const;
    void setFloat(const std::string &name, float value) const;
};

}

#endif /* Shader_h */

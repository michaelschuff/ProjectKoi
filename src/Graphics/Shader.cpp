//
//  Shader.cpp
//  ProjectKoi
//
//  Created by Michael Schuff on 7/12/21.
//

#include "Shader.h"

koi::Shader::Shader() { }

koi::Shader::Shader(const char* vertexPath, const char* fragmentPath) {
    this->load(vertexPath, fragmentPath);
}

void koi::Shader::load(const char* vertexPath, const char* fragmentPath) {
    
    std::string vertexCode, fragmentCode;
    std::ifstream vShaderFile, fShaderFile;
    
    vShaderFile.exceptions(std::ifstream::failbit | std::ifstream::badbit);
    fShaderFile.exceptions(std::ifstream::failbit | std::ifstream::badbit);
    
    try {
        vShaderFile.open(vertexPath);
        fShaderFile.open(fragmentPath);

        vShaderFile.seekg(0, std::ios::end);
        vertexCode.reserve(vShaderFile.tellg());
        vShaderFile.seekg(0, std::ios::beg);
        vertexCode.assign((std::istreambuf_iterator<char>(vShaderFile)),
                           std::istreambuf_iterator<char>());
        
        fShaderFile.seekg(0, std::ios::end);
        fragmentCode.reserve(fShaderFile.tellg());
        fShaderFile.seekg(0, std::ios::beg);
        fragmentCode.assign((std::istreambuf_iterator<char>(fShaderFile)),
                             std::istreambuf_iterator<char>());
        
    } catch(std::ifstream::failure e) {
        std::cout << "ERROR::SHADER::FILE_NOT_SUCCESFULLY_READ" << std::endl;
    }
    
//    const char* vShaderCode = vertexCode.c_str();
//    const char* fShaderCode = fragmentCode.c_str();
//    unsigned int vertex, fragment;
//    
//    // Load vertex shader
//    vertex = glCreateShader(GL_VERTEX_SHADER);
//    glShaderSource(vertex, 1, &vShaderCode, NULL);
//    glCompileShader(vertex);
//    
//    // Load fragment shader
//    fragment = glCreateShader(GL_FRAGMENT_SHADER);
//    glShaderSource(fragment, 1, &fShaderCode, NULL);
//    glCompileShader(fragment);
//    
//    
//    // Link shaders
//    ID = glCreateProgram();
//    glAttachShader(ID, vertex);
//    glAttachShader(ID, fragment);
//    glLinkProgram(ID);
//    
//    // Check for errors
//    int success;
//    char infoLog[512];
//    glGetShaderiv(vertex, GL_COMPILE_STATUS, &success);
//    if (!success) {
//        glGetShaderInfoLog(vertex, 512, NULL, infoLog);
//        std::cout << "ERROR::SHADER::VERTEX::COMPILATION_FAILED\n" << infoLog << std::endl;
//    };
//    glGetShaderiv(fragment, GL_COMPILE_STATUS, &success);
//    if (!success) {
//        glGetShaderInfoLog(fragment, 512, NULL, infoLog);
//        std::cout << "ERROR::SHADER::FRAGMENT::COMPILATION_FAILED\n" << infoLog << std::endl;
//    };
//    glGetProgramiv(ID, GL_LINK_STATUS, &success);
//    if(!success) {
//        glGetProgramInfoLog(ID, 512, NULL, infoLog);
//        std::cout << "ERROR::SHADER::PROGRAM::LINKING_FAILED\n" << infoLog << std::endl;
//    }
//    
//    // delete shaders
//    glDeleteShader(vertex);
//    glDeleteShader(fragment);
}

void koi::Shader::use() {
   glUseProgram(ID);
}

void koi::Shader::setBool(const std::string &name, bool value) const {
    glUniform1i(glGetUniformLocation(ID, name.c_str()), (int)value);
}
void koi::Shader::setInt(const std::string &name, int value) const {
    glUniform1i(glGetUniformLocation(ID, name.c_str()), value);
}
void koi::Shader::setFloat(const std::string &name, float value) const {
    glUniform1f(glGetUniformLocation(ID, name.c_str()), value);
}

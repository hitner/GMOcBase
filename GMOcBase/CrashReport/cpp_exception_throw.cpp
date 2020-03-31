//
//  cpp_exception_throw.cpp
//  GMOcBase
//
//  Created by liu zhuzhai on 2020/3/18.
//

#include "cpp_exception_throw.hpp"

#include <exception>

class MyException: public std::exception
{
public:
    virtual const char* what() const noexcept;
};

const char* MyException::what() const noexcept
{
    return "Something bad happened...";
}

void throw_a_cpp_exception() {
    throw MyException();
}



void call_terminate(void) {
    std::terminate();
}

#include <stdio.h>
#include "golib.h"

_GoString_ msg = {
   "Hello from C",
   12
};

int main() {

    Hello();

    //Call Log() - passing static string value
    Log(msg);

    _GoString_ amsg = {"Hello from auto (stack) var in C", 24};
    Log(amsg);

}

//
//  env.hpp
//  OpenAttributeGraphCxx

#ifndef env_hpp
#define env_hpp

#include <OpenAttributeGraph/OAGBase.h>

namespace OAG {
OAG_INLINE
int get_env(const char *name) {
    char *value = getenv(name);
    if (value) {
        return atoi(value);
    } else {
        return 0;
    }
}
}

#endif /* env_hpp */

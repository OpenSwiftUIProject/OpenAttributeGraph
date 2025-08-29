//
//  free_deleter.hpp
//  OpenAttributeGraphCxx
//
//  Status: Complete
//  Modified based Compute code

#ifndef OPENATTRIBUTEGRAPH_CXX_UTIL_FREE_DELETER_HPP
#define OPENATTRIBUTEGRAPH_CXX_UTIL_FREE_DELETER_HPP

#include <OpenAttributeGraph/OAGBase.h>

OAG_ASSUME_NONNULL_BEGIN

namespace util {

class free_deleter {
public:
    template <typename T> void operator()(T *_Nullable ptr) {
       if (ptr) {
           free((void *)ptr);
       }
    }
}; /* class free_deleter */

} /* namespace util */

OAG_ASSUME_NONNULL_END

#endif /* OPENATTRIBUTEGRAPH_CXX_UTIL_FREE_DELETER_HPP */

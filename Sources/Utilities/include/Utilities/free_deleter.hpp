//
//  free_deleter.hpp
//  Utilities
//
//  Audited for 6.5.4
//  Status: Complete

#ifndef UTILITIES_FREE_DELETER_HPP
#define UTILITIES_FREE_DELETER_HPP

#include <Utilities/Base.hpp>

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

#endif /* UTILITIES_FREE_DELETER_HPP */

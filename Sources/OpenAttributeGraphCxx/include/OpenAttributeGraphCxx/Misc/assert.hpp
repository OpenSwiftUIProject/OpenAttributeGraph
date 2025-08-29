//
//  assert.hpp
//  OpenAttributeGraphCxx

#ifndef assert_hpp
#define assert_hpp

#include <OpenAttributeGraph/OAGBase.h>

namespace OAG {
void precondition_failure(const char *format, ...) __cold __dead2;
void non_fatal_precondition_failure(const char *format, ...);
} /* OAG */

#endif /* assert_hpp */

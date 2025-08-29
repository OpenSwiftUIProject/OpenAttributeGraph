//
//  realloc_vector.hpp
//  OpenAttributeGraphCxx

#ifndef realloc_vector_hpp
#define realloc_vector_hpp

#include <OpenAttributeGraph/OAGBase.h>

OAG_ASSUME_NONNULL_BEGIN

namespace OAG {
namespace details {
template <typename T = uint32_t, size_t Alignment>
void *_Nullable realloc_vector(void* ptr, T& size, T new_size);

template <typename T = uint32_t, size_t Alignment>
void *_Nullable realloc_vector(void* src, void* dst, T dstSize, T& size, T newSize);
} /* details */
} /* OAG */

OAG_ASSUME_NONNULL_END

#endif /* realloc_vector_hpp */

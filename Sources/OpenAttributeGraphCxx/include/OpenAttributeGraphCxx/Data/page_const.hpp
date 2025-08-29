//
//  page_const.hpp
//  OpenAttributeGraphCxx

#ifndef page_const_hpp
#define page_const_hpp

#include <OpenAttributeGraph/OAGBase.h>

namespace OAG {
namespace data {

constexpr const uint32_t page_mask_bits = 9;

/// 0x200
constexpr const uint32_t page_size = 1 << page_mask_bits;

/// 0x1FF
constexpr const uint32_t page_mask = page_size - 1;

/// 0xFFFF_FE00
constexpr const uintptr_t page_alignment = ~page_mask;

} /* data */
} /* OAG */


#endif /* page_const_hpp */

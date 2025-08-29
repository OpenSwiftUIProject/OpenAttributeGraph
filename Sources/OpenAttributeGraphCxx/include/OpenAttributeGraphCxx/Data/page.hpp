//
//  page.hpp
//  OpenAttributeGraphCxx

#ifndef page_hpp
#define page_hpp

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraphCxx/Data/ptr.hpp>

namespace OAG {
namespace data {

class zone;
template <typename T> class ptr;

struct page {
    zone *zone;
    ptr<page> previous;
    uint32_t total;
    uint32_t in_use;
}; /* page */

} /* data */
} /* OAG */

#endif /* page_hpp */

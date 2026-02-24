//
//  ptr.hpp
//  OpenAttributeGraphCxx
//
//  Status: Complete

#ifndef ptr_hpp
#define ptr_hpp

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraphCxx/Data/table.hpp>
#include <OpenAttributeGraphCxx/Data/page_const.hpp>
#include <bitset>

OAG_ASSUME_NONNULL_BEGIN

namespace OAG {
namespace data {

struct page;

template <typename T> class ptr {
public:
    using element_type = T;
    using difference_type = uint32_t;

public:
    OAG_INLINE OAG_CONSTEXPR ptr(difference_type offset = 0) : _offset(offset){};
    OAG_INLINE OAG_CONSTEXPR ptr(std::nullptr_t){};

    // FIXME: this should be put into table API
    OAG_INLINE
    element_type *_Nonnull get(vm_address_t base = shared_table().data_base()) const OAG_NOEXCEPT {
        assert(_offset != 0);
        return reinterpret_cast<element_type *>(base + _offset);
    }

    OAG_INLINE OAG_CONSTEXPR
    ptr<page> page_ptr() const OAG_NOEXCEPT { return ptr<page>(_offset & page_alignment); }

    OAG_INLINE OAG_CONSTEXPR
    uint32_t page_index() const OAG_NOEXCEPT { return (_offset >> page_mask_bits) - 1; }

    OAG_INLINE OAG_CONSTEXPR
    difference_type page_relative_offset() const OAG_NOEXCEPT { return _offset & page_mask; }

    template <typename U> ptr<U> aligned(difference_type alignment_mask = sizeof(difference_type) - 1) const {
        return ptr<U>((_offset + alignment_mask) & ~alignment_mask);
    };

    OAG_INLINE OAG_CONSTEXPR
    operator bool() const OAG_NOEXCEPT { return _offset != 0; };

    OAG_INLINE OAG_CONSTEXPR
    std::add_lvalue_reference_t<T> operator*() const OAG_NOEXCEPT { return *get(); };

    OAG_INLINE OAG_CONSTEXPR
    T *_Nonnull operator->() const OAG_NOEXCEPT { return get(); };

    OAG_INLINE OAG_CONSTEXPR
    bool operator==(std::nullptr_t) const OAG_NOEXCEPT { return _offset == 0; };

    OAG_INLINE OAG_CONSTEXPR
    bool operator!=(std::nullptr_t) const OAG_NOEXCEPT { return _offset != 0; };

    OAG_INLINE OAG_CONSTEXPR
    bool operator<(difference_type offset) const OAG_NOEXCEPT { return _offset < offset; };

    OAG_INLINE OAG_CONSTEXPR
    bool operator<=(difference_type offset) const OAG_NOEXCEPT { return _offset <= offset; };

    OAG_INLINE OAG_CONSTEXPR
    bool operator>(difference_type offset) const OAG_NOEXCEPT { return _offset > offset; };

    OAG_INLINE OAG_CONSTEXPR
    bool operator>=(difference_type offset) const OAG_NOEXCEPT { return _offset >= offset; };

    template <typename U>
    OAG_INLINE OAG_CONSTEXPR
    ptr<U> operator+(difference_type shift) const OAG_NOEXCEPT { return ptr(_offset + shift); };

    template <typename U>
    OAG_INLINE OAG_CONSTEXPR
    ptr<U> operator-(difference_type shift) const OAG_NOEXCEPT { return ptr(_offset - shift); };

    template <typename U>
    OAG_INLINE OAG_CONSTEXPR
    difference_type operator-(const ptr<U> &other) const OAG_NOEXCEPT {
        return _offset - other._offset;
    };
private:
    difference_type _offset;
    
    template <typename U> friend class ptr;
    friend class table;
}; /* ptr */

} /* data */
} /* OAG */

OAG_ASSUME_NONNULL_END

#endif /* ptr_hpp */

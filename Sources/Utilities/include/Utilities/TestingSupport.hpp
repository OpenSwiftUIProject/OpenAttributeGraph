//
//  TestingSupport.hpp
//  Utilities
//
//  Test-only types and helpers for Swift C++ interop testing.

#pragma once

#ifdef SWIFT_TESTING

#include <Utilities/ForwardList.hpp>
#include <Utilities/Heap.hpp>
#include <Utilities/cf_ptr.hpp>
#include <CoreFoundation/CFData.h>

OAG_ASSUME_NONNULL_BEGIN

namespace util {

// MARK: - ForwardList

class UInt64ForwardList : public ForwardList<uint64_t> {
  public:
    static UInt64ForwardList *create();
    static void destroy(UInt64ForwardList *value);

    bool empty() const noexcept;

    uint64_t front();

    void push_front(const uint64_t &element);
    void push_front(uint64_t &&element);

    void pop_front();

} SWIFT_UNSAFE_REFERENCE;

UInt64ForwardList *UInt64ForwardList::create() { return new UInt64ForwardList(); }

void UInt64ForwardList::destroy(UInt64ForwardList *value) { delete value; }

bool UInt64ForwardList::empty() const noexcept { return ForwardList<uint64_t>::empty(); }

uint64_t UInt64ForwardList::front() { return ForwardList<uint64_t>::front(); }

void UInt64ForwardList::push_front(const uint64_t &element) { ForwardList<uint64_t>::push_front(element); }

void UInt64ForwardList::push_front(uint64_t &&element) { ForwardList<uint64_t>::push_front(element); }

void UInt64ForwardList::pop_front() { ForwardList<uint64_t>::pop_front(); }

// MARK: - Heap

OAG_INLINE uint64_t *_Nonnull heap_alloc_uint64(Heap *heap, size_t count = 1) SWIFT_RETURNS_INDEPENDENT_VALUE {
    return heap->alloc<uint64_t>(count);
}

// MARK: - cf_ptr

using cf_data_ptr = cf_ptr<CFDataRef>;
using cf_mutable_data_ptr = cf_ptr<CFMutableDataRef>;

} /* namespace util */

OAG_ASSUME_NONNULL_END

#endif /* SWIFT_TESTING */

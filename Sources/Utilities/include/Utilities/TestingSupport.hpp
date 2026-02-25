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

class CFPtrTestHelper {
    cf_data_ptr _ptr;

public:
    static CFPtrTestHelper *create() { return new CFPtrTestHelper(); }

    static CFPtrTestHelper *create(const UInt8 *_Nullable bytes, CFIndex length) {
        auto *helper = new CFPtrTestHelper();
        CFDataRef data = CFDataCreate(kCFAllocatorDefault, bytes, length);
        helper->_ptr = cf_data_ptr(data);
        CFRelease(data);
        return helper;
    }

    static void destroy(CFPtrTestHelper *value) { delete value; }

    bool has_value() const { return bool(_ptr); }

    CFIndex data_length() const {
        auto data = _ptr.get();
        return data ? CFDataGetLength(data) : -1;
    }

    CFIndex retain_count() const {
        auto data = _ptr.get();
        return data ? CFGetRetainCount(data) : 0;
    }

    void reset() { _ptr.reset(nullptr); }

    void reset_with(const UInt8 *_Nullable bytes, CFIndex length) {
        CFDataRef data = CFDataCreate(kCFAllocatorDefault, bytes, length);
        _ptr.reset(data);
        CFRelease(data);
    }

    CFPtrTestHelper *copy_to_new() const {
        auto *result = new CFPtrTestHelper();
        result->_ptr = _ptr;
        return result;
    }

    CFPtrTestHelper *move_to_new() {
        auto *result = new CFPtrTestHelper();
        result->_ptr = std::move(_ptr);
        return result;
    }
} SWIFT_UNSAFE_REFERENCE;

} /* namespace util */

OAG_ASSUME_NONNULL_END

// MARK: - objc_ptr

#if OAG_TARGET_OS_DARWIN
#include <Utilities/objc_ptr.hpp>
#include <objc/message.h>

OAG_ASSUME_NONNULL_BEGIN

namespace util {

using objc_id_ptr = objc_ptr<id>;

class ObjCPtrTestHelper {
    objc_id_ptr _ptr;

    static id create_nsobject() {
        id cls = (id)objc_getClass("NSObject");
        return ((id (*)(id, SEL))objc_msgSend)(cls, sel_registerName("new"));
    }

public:
    static ObjCPtrTestHelper *create() { return new ObjCPtrTestHelper(); }

    static ObjCPtrTestHelper *create_with_nsobject() {
        auto *helper = new ObjCPtrTestHelper();
        id obj = create_nsobject();
        helper->_ptr = objc_id_ptr(obj);
        objc_release(obj);
        return helper;
    }

    static void destroy(ObjCPtrTestHelper *value) { delete value; }

    bool has_value() const { return bool(_ptr); }

    void store_nsobject() {
        id obj = create_nsobject();
        _ptr = objc_id_ptr(obj);
        objc_release(obj);
    }

    void reset() { _ptr.reset(nil); }

    bool same_object(const ObjCPtrTestHelper &other) const {
        return _ptr.get() == other._ptr.get();
    }

    ObjCPtrTestHelper *copy_to_new() const {
        auto *result = new ObjCPtrTestHelper();
        result->_ptr = _ptr;
        return result;
    }

    ObjCPtrTestHelper *move_to_new() {
        auto *result = new ObjCPtrTestHelper();
        result->_ptr = std::move(_ptr);
        return result;
    }
} SWIFT_UNSAFE_REFERENCE;

} /* namespace util */
#endif

OAG_ASSUME_NONNULL_END

#endif /* SWIFT_TESTING */

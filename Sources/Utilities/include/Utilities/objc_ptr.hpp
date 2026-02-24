//
//  objc_ptr.hpp
//  Utilities
//
//  Audited for 6.5.4
//  Status: Complete

#ifndef UTILITIES_OBJC_PTR_HPP
#define UTILITIES_OBJC_PTR_HPP

#include <Utilities/Base.hpp>

#if OAG_TARGET_OS_DARWIN
#include <objc/objc.h>
#include <objc/runtime.h>

OAG_ASSUME_NONNULL_BEGIN

// Redeclare APIs from the Objective-C runtime.
// These functions are not available through public headers, but are guaranteed
// to exist on OS X >= 10.9 and iOS >= 7.0.
OBJC_EXPORT id objc_retain(id obj);
OBJC_EXPORT void objc_release(id obj);

namespace util {

template <typename T> class objc_ptr {
private:
    id _storage;

    static OAG_INLINE id to_storage(T obj) { return (id)obj; }
    static OAG_INLINE T from_storage(id storage) { return (T)storage; }

public:
    OAG_CONSTEXPR objc_ptr() OAG_NOEXCEPT : _storage(nil) {}
    OAG_CONSTEXPR objc_ptr(std::nullptr_t) OAG_NOEXCEPT : _storage(nil) {}

    explicit objc_ptr(T obj) : _storage(to_storage(obj)) {
       if (_storage) {
           objc_retain(_storage);
       }
    }

    ~objc_ptr() {
       if (_storage) {
           objc_release(_storage);
       }
    }

    // MARK: - Copy and move constructors

    objc_ptr(const objc_ptr &other) OAG_NOEXCEPT : _storage(other._storage) {
       if (_storage) {
           objc_retain(_storage);
       }
    }

    objc_ptr(objc_ptr &&other) OAG_NOEXCEPT : _storage(other._storage) {
       other._storage = nil;
    }

    // MARK: -  Copy and move assignment operators

    objc_ptr &operator=(const objc_ptr &other) OAG_NOEXCEPT {
       if (this != &other) {
           if (_storage) {
               objc_release(_storage);
           }
           _storage = other._storage;
           if (_storage) {
               objc_retain(_storage);
           }
       }
       return *this;
    }

    objc_ptr &operator=(objc_ptr &&other) OAG_NOEXCEPT {
       if (this != &other) {
           if (_storage) {
               objc_release(_storage);
           }
           _storage = other._storage;
           other._storage = nil;
       }
       return *this;
    }

    // MARK: - Modifiers

    void reset() OAG_NOEXCEPT { reset(nil); }

    void reset(T obj = nil) OAG_NOEXCEPT {
       if (_storage != obj) {
           if (_storage) {
               objc_release(_storage);
           }
           _storage = to_storage(obj);
           if (_storage) {
               objc_retain(_storage);
           }
       }
    }

    T get() const OAG_NOEXCEPT { return from_storage(_storage); }

    explicit operator bool() const OAG_NOEXCEPT { return _storage != nil; }
}; /* class objc_ptr */

} /* namespace util */

OAG_ASSUME_NONNULL_END

#endif

#endif /* UTILITIES_OBJC_PTR_HPP */

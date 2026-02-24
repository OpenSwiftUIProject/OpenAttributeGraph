//
//  cf_ptr.hpp
//  Utilities
//
//  Audited for 6.5.4
//  Status: Complete

#ifndef UTILITIES_CF_PTR_HPP
#define UTILITIES_CF_PTR_HPP

#include <Utilities/Base.hpp>

OAG_ASSUME_NONNULL_BEGIN

namespace util {

template <typename T> class cf_ptr {
private:
    CFTypeRef _storage;

    static OAG_INLINE CFTypeRef to_storage(T ref) { return (CFTypeRef)(ref); }
    static OAG_INLINE T from_storage(CFTypeRef storage) { return (T)storage; }

public:
    OAG_CONSTEXPR cf_ptr() OAG_NOEXCEPT : _storage(nullptr) {}
    OAG_CONSTEXPR cf_ptr(std::nullptr_t) OAG_NOEXCEPT : _storage(nullptr) {}

    explicit cf_ptr(T ref) : _storage(to_storage(ref)) {
       if (_storage) {
           CFRetain(_storage);
       }
    }

    ~cf_ptr() {
       if (_storage) {
           CFRelease(_storage);
       }
    }

    // Copy and move constructors

    cf_ptr(const cf_ptr &other) OAG_NOEXCEPT : _storage(other._storage) {
       if (_storage) {
           CFRetain(_storage);
       }
    };

    cf_ptr(cf_ptr &&other) OAG_NOEXCEPT : _storage(std::exchange(other._storage, nullptr)) {};

    // Copy and move assignment operators

    cf_ptr &operator=(const cf_ptr &other) OAG_NOEXCEPT {
       if (this != &other) {
           if (_storage) {
               CFRelease(_storage);
           }
           _storage = other._storage;
           if (_storage) {
               CFRetain(_storage);
           }
       }
       return *this;
    };

    cf_ptr &operator=(cf_ptr &&other) OAG_NOEXCEPT {
       if (this != &other) {
           if (_storage) {
               CFRelease(_storage);
           }
           _storage = other._storage;
           other._storage = nullptr;
       }
       return *this;
    }

    // Modifiers

    void reset() OAG_NOEXCEPT { reset(nullptr); }

    void reset(T ref = nullptr) OAG_NOEXCEPT {
       if (_storage != ref) {
           if (_storage) {
               CFRelease(_storage);
           }
           _storage = to_storage(ref);
           if (_storage) {
               CFRetain(_storage);
           }
       }
    }

    // Observers

    T get() const OAG_NOEXCEPT { return from_storage(_storage); };

    explicit operator bool() const OAG_NOEXCEPT { return _storage != nullptr; }
}; /* class cf_ptr */

#ifdef SWIFT_TESTING
using cf_data_ptr = cf_ptr<CFDataRef>;
using cf_mutable_data_ptr = cf_ptr<CFMutableDataRef>;
#endif /* SWIFT_TESTING */

} /* namespace util */

OAG_ASSUME_NONNULL_END

#endif /* UTILITIES_CF_PTR_HPP */

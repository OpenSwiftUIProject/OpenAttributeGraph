#pragma once

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

#ifndef __has_feature
#define __has_feature(x) 0
#endif
#ifndef __has_extension
#define __has_extension(x) 0
#endif

#if !defined(PLATFORM_EXTERN_C_BEGIN)
#if defined(__cplusplus)
#define PLATFORM_EXTERN_C_BEGIN extern "C" {
#define PLATFORM_EXTERN_C_END   }
#else
#define PLATFORM_EXTERN_C_BEGIN
#define PLATFORM_EXTERN_C_END
#endif
#endif

#if __GNUC__
#define PLATFORM_EXPORT extern __attribute__((__visibility__("default")))
#else
#define PLATFORM_EXPORT extern
#endif

#if __GNUC__
#define PLATFORM_INLINE static __inline__
#else
#define PLATFORM_INLINE static inline
#endif

#if __has_feature(assume_nonnull)
#define PLATFORM_ASSUME_NONNULL_BEGIN _Pragma("clang assume_nonnull begin")
#define PLATFORM_ASSUME_NONNULL_END   _Pragma("clang assume_nonnull end")
#else
#define PLATFORM_ASSUME_NONNULL_BEGIN
#define PLATFORM_ASSUME_NONNULL_END
#endif

#if !__has_feature(nullability)
#ifndef _Nullable
#define _Nullable
#endif
#ifndef _Nonnull
#define _Nonnull
#endif
#ifndef _Null_unspecified
#define _Null_unspecified
#endif
#endif

#if __has_feature(objc_fixed_enum) || __has_extension(cxx_fixed_enum) || \
        __has_extension(cxx_strong_enums)
#define PLATFORM_ENUM(_name, _type, ...) \
    typedef enum : _type { __VA_ARGS__ } _name##_t
#else
#define PLATFORM_ENUM(_name, _type, ...) \
    typedef _type _name##_t; enum { __VA_ARGS__ }
#endif

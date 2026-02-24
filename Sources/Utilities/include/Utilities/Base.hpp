//
//  Base.hpp
//  Utilities
//
//  Foundational macros for the Utilities module.
//  Based on Compute's Utilities/Base.h

#pragma once

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

#if defined(__cplusplus)
#include <cassert>
#include <cstddef>
#include <utility>
#endif

#ifndef __has_feature
#define __has_feature(x) 0
#endif
#ifndef __has_attribute
#define __has_attribute(x) 0
#endif
#ifndef __has_extension
#define __has_extension(x) 0
#endif
#ifndef __has_include
#define __has_include(x) 0
#endif

// MARK: - Nullability

#if __has_feature(assume_nonnull)
#define OAG_ASSUME_NONNULL_BEGIN _Pragma("clang assume_nonnull begin")
#define OAG_ASSUME_NONNULL_END   _Pragma("clang assume_nonnull end")
#else
#define OAG_ASSUME_NONNULL_BEGIN
#define OAG_ASSUME_NONNULL_END
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

// MARK: - Compiler attributes

#if defined(__GNUC__)
#define OAG_INLINE __inline__ __attribute__((always_inline))
#elif defined(__cplusplus)
#define OAG_INLINE inline
#else
#define OAG_INLINE
#endif

#if defined(__cplusplus)
#define OAG_CONSTEXPR constexpr
#else
#define OAG_CONSTEXPR
#endif

#if defined(__cplusplus)
#define OAG_NOEXCEPT noexcept
#else
#define OAG_NOEXCEPT
#endif

// MARK: - Target conditionals

#if __APPLE__
#define OAG_TARGET_OS_DARWIN 1
#else
#define OAG_TARGET_OS_DARWIN 0
#endif

#include <CoreFoundation/CoreFoundation.h>

// MARK: - Swift bridging

#include <SwiftBridging/SwiftBridging.h>

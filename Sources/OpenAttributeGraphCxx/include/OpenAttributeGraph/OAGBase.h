//
//  OAGBase.h
//  OpenAttributeGraphCxx

#ifndef OAGBase_h
#define OAGBase_h

#if DEBUG
#define OAG_ASSERTION
#else
#undef OAG_ASSERTION
#endif

#if __has_attribute(cold)
#define __cold __attribute__((__cold__))
#else
#define __cold
#endif

#if __has_attribute(noreturn)
#define __dead2 __attribute__((__noreturn__))
#else
#define __dead2
#endif

#if defined(__cplusplus)
#define OAG_NOEXCEPT noexcept
#else
#define OAG_NOEXCEPT
#endif

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

#if __has_include(<ptrcheck.h>) // Fix conflict define issue of the SDK
#include <ptrcheck.h>
#define OAG_COUNTED_BY(N) __counted_by(N)
#else
#if !defined(__counted_by)
#if __has_attribute(__counted_by__)
#define __counted_by(N) __attribute__((__counted_by__(N)))
#else
#define __counted_by(N)
#endif
#endif
#define OAG_COUNTED_BY(N) __counted_by(N)
#endif

#include "OAGSwiftSupport.h"
#include "OAGTargetConditionals.h"
#if OAG_TARGET_OS_DARWIN
#include <CoreFoundation/CoreFoundation.h>
#else
#include <SwiftCorelibsCoreFoundation/CoreFoundation.h>
#endif
#include <stdbool.h>
#include <stdint.h>

#define OAG_ENUM CF_ENUM
#define OAG_CLOSED_ENUM CF_CLOSED_ENUM
#define OAG_OPTIONS CF_OPTIONS
#define OAG_EXTERN_C_BEGIN CF_EXTERN_C_BEGIN
#define OAG_EXTERN_C_END CF_EXTERN_C_END
#define OAG_ASSUME_NONNULL_BEGIN CF_ASSUME_NONNULL_BEGIN
#define OAG_ASSUME_NONNULL_END CF_ASSUME_NONNULL_END
#define OAG_IMPLICIT_BRIDGING_ENABLED CF_IMPLICIT_BRIDGING_ENABLED
#define OAG_IMPLICIT_BRIDGING_DISABLED CF_IMPLICIT_BRIDGING_DISABLED
#define OAG_EXPORT CF_EXPORT
#define OAG_BRIDGED_TYPE CF_BRIDGED_TYPE

#if OAG_TARGET_OS_DARWIN && __OBJC__
#define OAG_OBJC_FOUNDATION 1
#else
#define OAG_OBJC_FOUNDATION 0
#endif /* OAG_TARGET_OS_DARWIN && __OBJC__ */

#endif /* OAGBase_h */

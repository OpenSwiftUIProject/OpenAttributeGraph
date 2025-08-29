//
//  OAGSwiftSupport.h
//  OpenAttributeGraphCxx

#ifndef OAGSwiftSupport_h
#define OAGSwiftSupport_h

#if __has_attribute(swift_name)
#define OAG_SWIFT_NAME(_name) __attribute__((swift_name(#_name)))
#else
#define OAG_SWIFT_NAME
#endif

#if __has_attribute(swift_wrapper)
#define OAG_SWIFT_STRUCT __attribute__((swift_wrapper(struct)))
#else
#define OAG_SWIFT_STRUCT
#endif

#if __has_attribute(swift_private)
#define OAG_REFINED_FOR_SWIFT __attribute__((swift_private))
#else
#define OAG_REFINED_FOR_SWIFT
#endif

// MARK: - Call Convension

#define OAG_SWIFT_CC(CC) OAG_SWIFT_CC_##CC
// OAG_SWIFT_CC(c) is the C calling convention.
#define OAG_SWIFT_CC_c

// OAG_SWIFT_CC(swift) is the Swift calling convention.
#if __has_attribute(swiftcall)
#define OAG_SWIFT_CC_swift __attribute__((swiftcall))
#define OAG_SWIFT_CONTEXT __attribute__((swift_context))
#define OAG_SWIFT_ERROR_RESULT __attribute__((swift_error_result))
#define OAG_SWIFT_INDIRECT_RESULT __attribute__((swift_indirect_result))
#else
#define OAG_SWIFT_CC_swift
#define OAG_SWIFT_CONTEXT
#define OAG_SWIFT_ERROR_RESULT
#define OAG_SWIFT_INDIRECT_RESULT
#endif

#endif /* OAGSwiftSupport_h */

//
//  OAGClosure.h
//  OpenAttributeGraphCxx

#ifndef OAGClosure_h
#define OAGClosure_h

#include <OpenAttributeGraph/OAGBase.h>

OAG_ASSUME_NONNULL_BEGIN

OAG_EXTERN_C_BEGIN

typedef struct OAGClosureStorage {
    const void *thunk;
    const void *_Nullable context;
} OAGClosureStorage OAG_SWIFT_NAME(_OAGClosureStorage);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGClosureStorage OAGRetainClosure(void (*thunk)(void *_Nullable context OAG_SWIFT_CONTEXT) OAG_SWIFT_CC(swift),
                                 void *_Nullable context);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGReleaseClosure(OAGClosureStorage closure);

OAG_EXTERN_C_END

OAG_ASSUME_NONNULL_END

#endif /* OAGClosure_h */

//
//  OAGWeakValue.h
//  OpenAttributeGraphCxx

#ifndef OAGWeakValue_h
#define OAGWeakValue_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGChangedValueFlags.h>

OAG_ASSUME_NONNULL_BEGIN

typedef struct OAGWeakValue {
    const void * _Nullable value;
    OAGChangedValueFlags flags;
} OAGWeakValue;

OAG_ASSUME_NONNULL_END

#endif /* OAGWeakValue_h */

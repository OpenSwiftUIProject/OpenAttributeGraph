//
//  OAGValue.h
//  OpenAttributeGraphCxx

#ifndef OAGValue_h
#define OAGValue_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGChangedValueFlags.h>

OAG_ASSUME_NONNULL_BEGIN

typedef struct OAGValue {
    const void *value;
    OAGChangedValueFlags flags;
} OAGValue;

OAG_ASSUME_NONNULL_END

#endif /* OAGValue_h */

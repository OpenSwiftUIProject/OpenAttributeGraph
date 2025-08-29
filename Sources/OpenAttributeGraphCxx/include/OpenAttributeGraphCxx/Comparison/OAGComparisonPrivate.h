//
//  OAGComparisonPrivate.h
//  OpenAttributeGraphCxx
//
//  Audited for 6.5.1
//  Status: Complete

#ifndef OAGComparisonPrivate_h
#define OAGComparisonPrivate_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGComparison.h>
#include <OpenAttributeGraph/OAGTypeID.h>

OAG_ASSUME_NONNULL_BEGIN

OAG_EXTERN_C_BEGIN

typedef struct OAGComparisonStateStorage {
    const void *destination;
    const void *source;
    OAGFieldRange field_range;
    OAGTypeID field_type;
} OAGComparisonStateStorage;

OAG_EXTERN_C_END

OAG_ASSUME_NONNULL_END

#endif /* OAGComparisonPrivate_h */


//
//  OAGAttributeInfo.h
//  OpenAttributeGraphCxx

#ifndef OAGAttributeInfo_h
#define OAGAttributeInfo_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGAttributeType.h>

OAG_ASSUME_NONNULL_BEGIN

typedef struct OAGAttributeInfo {
    const OAGAttributeType* type;
    const void *body;
} OAGAttributeInfo;

OAG_ASSUME_NONNULL_END

#endif /* OAGAttributeInfo_h */

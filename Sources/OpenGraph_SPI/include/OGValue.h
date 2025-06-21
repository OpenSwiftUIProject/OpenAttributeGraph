//
//  OGValue.h
//  OpenGraph_SPI

#ifndef OGValue_h
#define OGValue_h

#include "OGBase.h"

OG_ASSUME_NONNULL_BEGIN

typedef struct OGValue {
    const void* value;
    const bool changed;
} OGValue;

OG_ASSUME_NONNULL_END

#endif /* OGValue_h */

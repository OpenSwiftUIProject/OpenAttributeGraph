//
//  OAGCachedValueOptions.h
//  OpenAttributeGraphCxx

#ifndef OAGCachedValueOptions_h
#define OAGCachedValueOptions_h

#include <OpenAttributeGraph/OAGBase.h>

typedef OAG_OPTIONS(uint32_t, OAGCachedValueOptions) {
    OAGCachedValueOptions_0 = 0,
    OAGCachedValueOptions_1 = 1 << 0,
    OAGCachedValueOptions_2 = 1 << 1,
    OAGCachedValueOptions_4 = 1 << 2,
    OAGCachedValueOptions_8 = 1 << 3,
    OAGCachedValueOptions_16 = 1 << 4,
};

#endif /* OAGCachedValueOptions_h */


//
//  OAGValueOptions.h
//  OpenAttributeGraphCxx

#ifndef OAGValueOptions_h
#define OAGValueOptions_h

#include <OpenAttributeGraph/OAGBase.h>

typedef OAG_OPTIONS(uint32_t, OAGValueOptions) {
    OAGValueOptionsNone = 0,
    OAGValueOptionsInputOptionsUnprefetched = 1 << 0,
    OAGValueOptionsInputOptionsSyncMainRef = 1 << 1,
    OAGValueOptionsInputOptionsMask = 0x03,

    OAGValueOptionsIncrementGraphVersion = 1 << 2, // AsTopLevelOutput
};

#endif /* OAGValueOptions_h */

//
//  OAGInputOptions.h
//  OpenAttributeGraphCxx

#ifndef OAGInputOptions_h
#define OAGInputOptions_h

#include <OpenAttributeGraph/OAGBase.h>

typedef OAG_OPTIONS(uint32_t, OAGInputOptions) {
    OAGInputOptionsNone = 0,
    OAGInputOptionsUnprefetched = 1 << 0,
    OAGInputOptionsSyncMainRef = 1 << 1,
};

#endif /* OAGInputOptions_h */

//
//  OAGChangedValueFlags.h
//  OpenAttributeGraphCxx

#ifndef OAGChangedValueFlags_h
#define OAGChangedValueFlags_h

#include <OpenAttributeGraph/OAGBase.h>

typedef OAG_OPTIONS(uint32_t, OAGChangedValueFlags) {
    OAGChangedValueFlagsChanged = 1 << 0,
    OAGChangedValueFlagsRequiresMainThread = 1 << 1,
};

#endif /* OAGChangedValueFlags_h */

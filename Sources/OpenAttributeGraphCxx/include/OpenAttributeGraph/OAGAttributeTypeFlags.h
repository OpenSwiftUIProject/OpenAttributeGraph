//
//  OAGAttributeTypeFlags.h
//  OpenAttributeGraphCxx

#ifndef OAGAttributeTypeFlags_h
#define OAGAttributeTypeFlags_h

#include <OpenAttributeGraph/OAGBase.h>

typedef OAG_OPTIONS(uint32_t, OAGAttributeTypeFlags) {
    OAGAttributeTypeFlagsComparisonModeBitwise = 0,
    OAGAttributeTypeFlagsComparisonModeIndirect = 1,
    OAGAttributeTypeFlagsComparisonModeEquatableUnlessPOD = 2,
    OAGAttributeTypeFlagsComparisonModeEquatableAlways = 3,
    OAGAttributeTypeFlagsComparisonModeMask = 0x03,

    OAGAttributeTypeFlagsHasDestroySelf = 1 << 2,
    OAGAttributeTypeFlagsMainThread = 1 << 3,
    OAGAttributeTypeFlagsExternal = 1 << 4,
    OAGAttributeTypeFlagsAsyncThread = 1 << 5,
} OAG_SWIFT_NAME(OAGAttributeType.Flags);

#endif /* OAGAttributeTypeFlags_h */


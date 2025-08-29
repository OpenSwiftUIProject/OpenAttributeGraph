//
//  OAGAttributeFlags.h
//  OpenAttributeGraphCxx
//
//  Audited for RELEASE_2021
//  Status: Complete

#ifndef OAGAttributeFlags_h
#define OAGAttributeFlags_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGGraph.h>

typedef OAG_OPTIONS(uint8_t, OAGAttributeFlags) {
    OAGAttributeFlagsNone = 0,
    OAGAttributeFlagsAll = 0xFF,
} OAG_SWIFT_NAME(OAGAttribute.Flags);

#endif /* OAGAttributeFlags_h */

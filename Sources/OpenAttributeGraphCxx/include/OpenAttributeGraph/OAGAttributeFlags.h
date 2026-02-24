//
//  OAGAttributeFlags.h
//  OpenAttributeGraphCxx
//
//  Audited for 3.2.1
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

//
//  OAGUniqueID.h
//  OpenAttributeGraphCxx
//
//  Audited for iOS 18.0
//  Status: Complete

#ifndef OAGUniqueID_h
#define OAGUniqueID_h

#include <OpenAttributeGraph/OAGBase.h>
typedef long OAGUniqueID;

OAG_EXTERN_C_BEGIN
OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGUniqueID OAGMakeUniqueID(void) OAG_SWIFT_NAME(makeUniqueID());
OAG_EXTERN_C_END

#endif /* OAGUniqueID_h */

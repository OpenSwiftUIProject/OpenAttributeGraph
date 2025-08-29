//
//  OAGUniqueID.c
//  OpenAttributeGraphCxx
//
//  Audited for iOS 18.0
//  Status: Complete

#include <OpenAttributeGraph/OAGUniqueID.h>
#include <stdatomic.h>

OAGUniqueID OAGMakeUniqueID(void) {
    // Initial value is 1
    static atomic_long counter = 1;
    return counter++;
}

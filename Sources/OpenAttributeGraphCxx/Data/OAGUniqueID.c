//
//  OAGUniqueID.c
//  OpenAttributeGraphCxx
//
//  Audited for 6.5.1
//  Status: Complete

#include <OpenAttributeGraph/OAGUniqueID.h>
#include <stdatomic.h>

OAGUniqueID OAGMakeUniqueID(void) {
    static atomic_ulong counter = 1;
    return atomic_fetch_add_explicit(&counter, 1, memory_order_relaxed);
}

//
//  OAGAttributeType.h
//  OpenAttributeGraphCxx

#ifndef OAGAttributeType_h
#define OAGAttributeType_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGAttributeTypeFlags.h>
#include <OpenAttributeGraph/OAGClosure.h>
#include <OpenAttributeGraph/OAGTypeID.h>

OAG_ASSUME_NONNULL_BEGIN

typedef struct OAGAttributeType OAGAttributeType;

typedef struct OAG_SWIFT_NAME(_AttributeVTable) OAGAttributeVTable {
    unsigned long version;
    void (*_Nullable type_destroy)(OAGAttributeType *);
    void (*_Nullable self_destroy)(const OAGAttributeType *, void *);
    CFStringRef _Nullable (*_Nullable self_description)(const OAGAttributeType *, const void *);
    CFStringRef _Nullable (*_Nullable value_description)(const OAGAttributeType *, const void *);
    void (*_Nullable update_default)(const OAGAttributeType *, void *);
} OAGAttributeVTable;

typedef struct OAG_SWIFT_NAME(_AttributeType) OAGAttributeType {
    OAGTypeID self_id;
    OAGTypeID value_id;
    OAGClosureStorage update;
    const OAGAttributeVTable *vtable;
    OAGAttributeTypeFlags flags;

    uint32_t internal_offset;
    const unsigned char *_Nullable value_layout;

    struct {
        OAGTypeID type_id;
        const void *witness_table;
    } body_conformance;
} OAGAttributeType;

OAG_ASSUME_NONNULL_END

#endif /* OAGAttributeType_h */

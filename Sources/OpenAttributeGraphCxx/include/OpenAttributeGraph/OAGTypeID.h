//
//  OAGTypeID.h
//  OpenAttributeGraphCxx
//
//  Audited for iOS 18.0
//  Status: Complete

#ifndef OAGTypeID_h
#define OAGTypeID_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGVersion.h>

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

typedef struct OAG_SWIFT_NAME(_Metadata) OAGSwiftMetadata {
} OAGSwiftMetadata;

typedef const OAGSwiftMetadata *OAGTypeID OAG_SWIFT_STRUCT OAG_SWIFT_NAME(Metadata);

typedef OAG_CLOSED_ENUM(uint32_t, OAGTypeKind) {
    OAGTypeKindNone,
    OAGTypeKindClass,
    OAGTypeKindStruct,
    OAGTypeKindEnum,
    OAGTypeKindOptional,
    OAGTypeKindTuple,
    OAGTypeKindFunction,
    OAGTypeKindExistential,
    OAGTypeKindMetatype,
} OAG_SWIFT_NAME(Metadata.Kind);

typedef OAG_OPTIONS(uint32_t, OAGTypeApplyOptions) {
    OAGTypeApplyOptionsEnumerateStructFields = 0,
    OAGTypeApplyOptionsEnumerateClassFields = 1 << 0,
    OAGTypeApplyOptionsContinueAfterUnknownField = 1 << 1,
    OAGTypeApplyOptionsEnumerateEnumCases = 1 << 2,
} OAG_SWIFT_NAME(Metadata.ApplyOptions);

#if OPENATTRIBUTEGRAPH_RELEASE >= OPENATTRIBUTEGRAPH_RELEASE_2024

typedef struct OAG_SWIFT_NAME(Signature) OAGTypeSignature {
    uint8_t bytes[20];
} OAGTypeSignature;

#endif

OAG_EXTERN_C_BEGIN

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTypeKind OAGTypeGetKind(OAGTypeID typeID) OAG_SWIFT_NAME(getter:Metadata.kind(self:));

// TODO
// OAGOverrideComparisonForTypeDescriptor();

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGTypeApplyFields(const void *type, const void *block, void *context);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGTypeApplyFields2(const void *type, OAGTypeApplyOptions options, const void *block, void *context);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
uint32_t OAGTypeGetEnumTag(OAGTypeID typeID, const void *value) OAG_SWIFT_NAME(Metadata.enumTag(self:_:));

#if OPENATTRIBUTEGRAPH_RELEASE >= OPENATTRIBUTEGRAPH_RELEASE_2024

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGTypeProjectEnumData(OAGTypeID typeID, void *value) OAG_SWIFT_NAME(Metadata.projectEnumData(self:_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGTypeInjectEnumTag(OAGTypeID typeID, uint32_t tag, void *value) OAG_SWIFT_NAME(Metadata.injectEnumTag(self:tag:_:));

#endif /* OPENATTRIBUTEGRAPH_RELEASE */

// TODO
OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGTypeApplyEnumData();

// TODO
OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGTypeApplyMutableEnumData();

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
CFStringRef OAGTypeDescription(OAGTypeID typeID);

#if OPENATTRIBUTEGRAPH_RELEASE >= OPENATTRIBUTEGRAPH_RELEASE_2024

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTypeSignature const OAGTypeGetSignature(OAGTypeID typeID) OAG_SWIFT_NAME(getter:Metadata.signature(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void const* _Nullable OAGTypeGetDescriptor(OAGTypeID typeID) OAG_SWIFT_NAME(getter:Metadata.descriptor(self:));

#endif /* OPENATTRIBUTEGRAPH_RELEASE */

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void const* _Nullable OAGTypeNominalDescriptor(OAGTypeID typeID) OAG_SWIFT_NAME(getter:Metadata.nominalDescriptor(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
char const* _Nullable OAGTypeNominalDescriptorName(OAGTypeID typeID) OAG_SWIFT_NAME(getter:Metadata.nominalDescriptorName(self:));

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGTypeID_h */

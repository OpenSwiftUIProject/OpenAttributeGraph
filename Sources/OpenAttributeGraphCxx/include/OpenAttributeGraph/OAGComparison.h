//
//  OAGComparison.h
//  OpenAttributeGraphCxx
//
//  Audited for 6.5.1
//  Status: Complete

#ifndef OAGComparison_h
#define OAGComparison_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGTypeID.h>

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

OAG_EXTERN_C_BEGIN

typedef struct OAG_SWIFT_NAME(FieldRange) OAGFieldRange {
    size_t offset;
    size_t size;
} OAGFieldRange;

typedef const void *OAGComparisonState OAG_SWIFT_STRUCT OAG_SWIFT_NAME(ComparisonState);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const void *OAGComparisonStateGetDestination(OAGComparisonState state) OAG_SWIFT_NAME(getter:OAGComparisonState.destination(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const void *OAGComparisonStateGetSource(OAGComparisonState state) OAG_SWIFT_NAME(getter:OAGComparisonState.source(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGFieldRange OAGComparisonStateGetFieldRange(OAGComparisonState state) OAG_SWIFT_NAME(getter:OAGComparisonState.fieldRange(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTypeID OAGComparisonStateGetFieldType(OAGComparisonState state) OAG_SWIFT_NAME(getter:OAGComparisonState.fieldType(self:));

typedef OAG_ENUM(uint8_t, OAGComparisonMode) {
    OAGComparisonModeBitwise = 0,
    OAGComparisonModeIndirect = 1,
    OAGComparisonModeEquatableUnlessPOD = 2,
    OAGComparisonModeEquatableAlways = 3,
} OAG_SWIFT_NAME(ComparisonMode);

typedef OAG_OPTIONS(uint32_t, OAGComparisonOptions) {
    OAGComparisonOptionsComparisonModeBitwise = 0,
    OAGComparisonOptionsComparisonModeIndirect = 1,
    OAGComparisonOptionsComparisonModeEquatableUnlessPOD = 2,
    OAGComparisonOptionsComparisonModeEquatableAlways = 3,
    OAGComparisonOptionsComparisonModeMask = 0xff,

    OAGComparisonOptionsCopyOnWrite = 1 << 8,
    OAGComparisonOptionsFetchLayoutsSynchronously = 1 << 9,
    OAGComparisonOptionsTraceCompareFailed = 1ul << 31, // -1 signed int
} OAG_SWIFT_NAME(ComparisonOptions);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGCompareValues(const void *lhs,
                     const void *rhs,
                     OAGTypeID type_id,
                     OAGComparisonOptions options);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const unsigned char *_Nullable OAGPrefetchCompareValues(OAGTypeID type_id,
                                                       OAGComparisonOptions options,
                                                       uint32_t priority);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGOverrideComparisonForTypeDescriptor(void *descriptor, OAGComparisonMode mode);

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGComparison_h */

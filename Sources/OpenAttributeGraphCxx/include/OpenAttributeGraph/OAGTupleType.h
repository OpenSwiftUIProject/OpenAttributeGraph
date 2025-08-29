//
//  OAGTupleType.h
//  OpenAttributeGraphCxx
//
//  Audited for iOS 18.0
//  Status: Complete

#ifndef OAGTupleType_h
#define OAGTupleType_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGTypeID.h>

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

typedef const OAGSwiftMetadata *OAGTupleType OAG_SWIFT_STRUCT OAG_SWIFT_NAME(TupleType);

typedef OAG_CLOSED_ENUM(uint32_t, OAGTupleCopyOptions) {
    OAGTupleCopyOptionsAssignCopy = 0,
    OAGTupleCopyOptionsInitCopy = 1,
    OAGTupleCopyOptionsAssignTake = 2,
    OAGTupleCopyOptionsInitTake = 3
} OAG_SWIFT_NAME(TupleType.CopyOptions);

typedef struct OAG_SWIFT_NAME(UnsafeTuple) OAGUnsafeTuple {
    OAGTupleType type;
    const void *value;
} OAGUnsafeTuple;

typedef struct OAG_SWIFT_NAME(UnsafeMutableTuple) OAGUnsafeMutableTuple {
    OAGTupleType type;
    void *value;
} OAGUnsafeMutableTuple;

OAG_EXTERN_C_BEGIN

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTupleType OAGNewTupleType(size_t count, const OAGTypeID _Nonnull * _Nonnull elements) OAG_SWIFT_NAME(TupleType.init(count:elements:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
size_t OAGTupleCount(OAGTupleType tuple_type) OAG_SWIFT_NAME(getter:TupleType.count(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
size_t OAGTupleSize(OAGTupleType tuple_type) OAG_SWIFT_NAME(getter:TupleType.size(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTypeID OAGTupleElementType(OAGTupleType tuple_type, size_t index) OAG_SWIFT_NAME(TupleType.elementType(self:at:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
size_t OAGTupleElementSize(OAGTupleType tuple_type, size_t index) OAG_SWIFT_NAME(TupleType.elementSize(self:at:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
size_t OAGTupleElementOffset(OAGTupleType tuple_type, size_t index) OAG_SWIFT_NAME(TupleType.elementOffset(self:at:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
size_t OAGTupleElementOffsetChecked(OAGTupleType tuple_type, size_t index, OAGTypeID check_type) OAG_SWIFT_NAME(TupleType.elementOffset(self:at:type:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void *OAGTupleSetElement(OAGTupleType tuple_type, void* tuple_value, size_t index, const void *element_value, OAGTypeID check_type, OAGTupleCopyOptions mode);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void *OAGTupleGetElement(OAGTupleType tuple_type, void* tuple_value, size_t index, void *element_value, OAGTypeID check_type, OAGTupleCopyOptions mode);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGTupleDestroy(OAGTupleType tuple_type, void *buffer) OAG_SWIFT_NAME(TupleType.destroy(self:_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGTupleDestroyElement(OAGTupleType tuple_type, void *buffer, size_t index) OAG_SWIFT_NAME(TupleType.destroy(self:_:at:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGTupleWithBuffer(OAGTupleType tuple_type, size_t count, const void (* function)(const OAGUnsafeMutableTuple mutableTuple, const void * context OAG_SWIFT_CONTEXT) OAG_SWIFT_CC(swift), const void *context);

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGTupleType_h */

//
//  OAGAttribute.h
//  OpenAttributeGraphCxx

#ifndef OAGAttribute_h
#define OAGAttribute_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGAttributeInfo.h>
#include <OpenAttributeGraph/OAGAttributeFlags.h>
#include <OpenAttributeGraph/OAGCachedValueOptions.h>
#include <OpenAttributeGraph/OAGGraph.h>
#include <OpenAttributeGraph/OAGInputOptions.h>
#include <OpenAttributeGraph/OAGTypeID.h>
#include <OpenAttributeGraph/OAGValue.h>
#include <OpenAttributeGraph/OAGValueOptions.h>
#include <OpenAttributeGraph/OAGValueState.h>

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

OAG_EXTERN_C_BEGIN

OAG_EXPORT
const OAGAttribute OAGAttributeNil;

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGGraphGetCurrentAttribute(void);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGGraphCurrentAttributeWasModified(void) OAG_SWIFT_NAME(getter:OAGAttribute.currentWasModified());

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGGraphCreateOffsetAttribute(OAGAttribute attribute, long offset) OAG_SWIFT_NAME(OAGAttribute.create(self:offset:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGGraphCreateOffsetAttribute2(OAGAttribute attribute, long offset, uint64_t size) OAG_SWIFT_NAME(OAGAttribute.create(self:offset:size:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGGraphCreateIndirectAttribute(OAGAttribute attribute) OAG_SWIFT_NAME(OAGAttribute.createIndirect(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGGraphCreateIndirectAttribute2(OAGAttribute attribute, uint64_t size) OAG_SWIFT_NAME(OAGAttribute.createIndirect(self:size:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttributeFlags OAGGraphGetFlags(OAGAttribute attribute) OAG_SWIFT_NAME(getter:OAGAttribute.flags(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphSetFlags(OAGAttribute attribute, OAGAttributeFlags flags) OAG_SWIFT_NAME(setter:OAGAttribute.flags(self:_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphAddInput(OAGAttribute attribute1, OAGAttribute attribute2, OAGInputOptions options, long token);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const OAGAttributeInfo OAGGraphGetAttributeInfo(OAGAttribute attribute) OAG_SWIFT_NAME(getter:OAGAttribute.info(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphMutateAttribute(OAGAttribute attribute,
                            const OAGTypeID type,
                            bool invalidating,
                            const void (*function)(const void * _Nullable context OAG_SWIFT_CONTEXT, void *body) OAG_SWIFT_CC(swift),
                            const void * _Nullable context);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGGraphGetIndirectDependency(OAGAttribute attribute) OAG_SWIFT_NAME(getter:OAGAttribute._indirectDependency(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphSetIndirectDependency(OAGAttribute attribute1, OAGAttribute attribute2) OAG_SWIFT_NAME(setter:OAGAttribute._indirectDependency(self:_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGGraphGetIndirectAttribute(OAGAttribute attribute) OAG_SWIFT_NAME(getter:OAGAttribute.source(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphSetIndirectAttribute(OAGAttribute attribute1, OAGAttribute attribute2) OAG_SWIFT_NAME(setter:OAGAttribute.source(self:_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGGraphCreateAttribute(long index, const void *body, const void * _Nullable value);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const OAGValue OAGGraphGetValue(OAGAttribute attribute, OAGValueOptions options, const OAGTypeID type);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGGraphSetValue(OAGAttribute attribute, const void *value, const OAGTypeID type);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const OAGValue OAGGraphGetInputValue(OAGAttribute attribute, OAGAttribute inputAttribute, OAGValueOptions options, const OAGTypeID type);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const void * _Nullable OAGGraphGetOutputValue(OAGTypeID type);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphSetOutputValue(const void *value, const OAGTypeID type);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGValueState OAGGraphGetValueState(OAGAttribute attribute) OAG_SWIFT_NAME(getter:OAGAttribute.valueState(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGGraphHasValue(OAGAttribute attribute) OAG_SWIFT_NAME(getter:OAGAttribute.hasValue(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphUpdateValue(OAGAttribute attribute) OAG_SWIFT_NAME(OAGAttribute.updateValue(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphPrefetchValue(OAGAttribute attribute) OAG_SWIFT_NAME(OAGAttribute.prefetchValue(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphInvalidateValue(OAGAttribute attribute) OAG_SWIFT_NAME(OAGAttribute.invalidateValue(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphVerifyType(OAGAttribute attribute, OAGTypeID type) OAG_SWIFT_NAME(OAGAttribute.verify(self:type:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGGraphRef OAGGraphGetAttributeGraph(OAGAttribute attribute) OAG_SWIFT_NAME(getter:OAGAttribute.graph(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGSubgraphRef OAGGraphGetAttributeSubgraph(OAGAttribute attribute) OAG_SWIFT_NAME(getter:OAGAttribute.subgraph(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
_Nullable OAGSubgraphRef OAGGraphGetAttributeSubgraph2(OAGAttribute attribute) OAG_SWIFT_NAME(getter:OAGAttribute.subgraph2(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const void * OAGGraphReadCachedAttribute(long hashValue, OAGTypeID bodyType, const void *bodyPointer, OAGTypeID valueType, OAGCachedValueOptions options, OAGAttribute attribute, bool unknown/*, ...*/);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const void * _Nullable OAGGraphReadCachedAttributeIfExists(long hashValue, OAGTypeID bodyType, const void *bodyPointer, OAGTypeID valueType, OAGCachedValueOptions options, OAGAttribute attribute, bool unknown);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphWithUpdate(
    OAGAttribute attribute,
    void (* callback)(const void *context OAG_SWIFT_CONTEXT) OAG_SWIFT_CC(swift),
    const void *context
);

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGAttribute_h */


#ifndef OpenAttributeGraphDanceUIGraphShims_h
#define OpenAttributeGraphDanceUIGraphShims_h

#include <stdbool.h>
#include <stdint.h>

#include <DanceUIGraph/DanceUIGraph.h>
#include <DanceUIGraph/DanceUISubgraph.h>
#include <DanceUIRuntime/DanceUISwiftSupport.h>

DANCE_UI_ASSUME_NONNULL_BEGIN

void * _Nullable OAGDanceUIGraphGetContext(DanceUIGraphRef graph) SWIFT_CC(swift);
void OAGDanceUIGraphSetContext(DanceUIGraphRef graph, void * _Nullable context) SWIFT_CC(swift);
DanceUIGraphAttribute OAGDanceUIGraphGetCurrentAttribute(void) SWIFT_CC(swift);
bool OAGDanceUIGraphCurrentAttributeWasModified(void) SWIFT_CC(swift);
DanceUIGraphAttribute OAGDanceUIGraphCurrentAttributeUpdatedReason(void) SWIFT_CC(swift);
void *OAGDanceUIGraphClearUpdate(void) SWIFT_CC(swift);
void OAGDanceUIGraphSetUpdate(void *update) SWIFT_CC(swift);
DanceUIGraphAttribute OAGDanceUIGraphCreateAttribute(DanceUIGraphTypeIndex typeID, const void *attribute, const void * _Nullable value) SWIFT_CC(swift);
DanceUIGraphValue OAGDanceUIGraphGetValue(DanceUIGraphAttribute attribute, DanceUIGraphInputOptions options, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift);
bool OAGDanceUIGraphSetValue(DanceUIGraphAttribute attribute, const void *value, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift);
DanceUIGraphValue OAGDanceUIGraphGetInputValue(DanceUIGraphAttribute destinationAttribute, DanceUIGraphAttribute inputAttribute, DanceUIGraphInputOptions options, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift);
const void * _Nullable OAGDanceUIGraphGetOutputValue(const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift);
void OAGDanceUIGraphSetOutputValue(const void *value, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift);
void OAGDanceUIGraphWithUpdate(DanceUIGraphAttribute attribute, void (*updateCallback)(void *ctx SWIFT_CONTEXT) SWIFT_CC(swift), const void *updateCallbackContext) SWIFT_CC(swift);
DanceUIGraphAttribute OAGDanceUIGraphCreateOffsetAttribute(DanceUIGraphAttribute attribute, int offset) SWIFT_CC(swift);
DanceUIGraphAttribute OAGDanceUIGraphCreateOffsetAttribute2(DanceUIGraphAttribute attribute, int offset, int size) SWIFT_CC(swift);
DanceUIGraphAttribute OAGDanceUIGraphCreateIndirectAttribute(DanceUIGraphAttribute attribute) SWIFT_CC(swift);
DanceUIGraphAttribute OAGDanceUIGraphCreateIndirectAttribute2(DanceUIGraphAttribute attribute, uint32_t size) SWIFT_CC(swift);
DanceUIGraphAttribute OAGDanceUIGraphGetIndirectAttribute(DanceUIGraphAttribute attribute) SWIFT_CC(swift);
void OAGDanceUIGraphSetIndirectAttribute(DanceUIGraphAttribute attribute, DanceUIGraphAttribute source) SWIFT_CC(swift);
DanceUIGraphAttribute OAGDanceUIGraphGetIndirectDependency(DanceUIGraphAttribute attribute) SWIFT_CC(swift);
void OAGDanceUIGraphSetIndirectDependency(DanceUIGraphAttribute attribute, DanceUIGraphAttribute dependency) SWIFT_CC(swift);
DanceUIGraphWeakAttribute OAGDanceUIGraphCreateWeakAttribute(DanceUIGraphAttribute attribute) SWIFT_CC(swift);
DanceUIGraphAttribute OAGDanceUIGraphWeakAttributeGetAttribute(DanceUIGraphWeakAttribute weakAttribute) SWIFT_CC(swift);
DanceUIGraphWeakValue OAGDanceUIGraphGetWeakValue(DanceUIGraphWeakAttribute weakAttribute, DanceUIGraphInputOptions options, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift);
DanceUIGraphAttributeInfo OAGDanceUIGraphGetAttributeInfo(DanceUIGraphAttribute attribute) SWIFT_CC(swift);
void OAGDanceUIGraphMutateAttribute(DanceUIGraphAttribute attribute, const DanceUIGraphSwiftMetadata *metadata, bool invalidate, void (*mutateBody)(void *ctx SWIFT_CONTEXT, void *attribute) SWIFT_CC(swift), const void *mutateBodyContext) SWIFT_CC(swift);
void OAGDanceUIGraphVerifyType(DanceUIGraphAttribute attribute, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift);
void OAGDanceUIGraphAddInput(DanceUIGraphAttribute toAttribute, DanceUIGraphAttribute fromAttribute, DanceUIGraphInputOptions inputOptions) SWIFT_CC(swift);
void OAGDanceUIGraphInvalidateAllValues(DanceUIGraphRef graph) SWIFT_CC(swift);
void OAGDanceUIGraphInvalidateValue(DanceUIGraphAttribute attribute) SWIFT_CC(swift);
bool OAGDanceUIGraphHasValue(DanceUIGraphAttribute attribute) SWIFT_CC(swift);
void OAGDanceUIGraphUpdateValue(DanceUIGraphAttribute attribute) SWIFT_CC(swift);
DanceUIGraphValueState OAGDanceUIGraphGetValueState(DanceUIGraphAttribute attribute) SWIFT_CC(swift);
bool OAGDanceUIGraphSearch(DanceUIGraphAttribute rootAttribute, DanceUIGraphSearchOptions options, bool (*body)(void *ctx SWIFT_CONTEXT, DanceUIGraphAttribute attribute) SWIFT_CC(swift), const void *bodyContext) SWIFT_CC(swift);
DanceUIGraphAttributeFlags OAGDanceUIGraphGetFlags(DanceUIGraphAttribute attribute) SWIFT_CC(swift);
void OAGDanceUIGraphSetFlags(DanceUIGraphAttribute attribute, DanceUIGraphAttributeFlags flags) SWIFT_CC(swift);
const void *OAGDanceUIGraphReadCachedAttribute(uintptr_t hashValue, const DanceUIGraphSwiftMetadata *selfMetadata, const void *attributeBody, const DanceUIGraphSwiftMetadata *valueMetadata, DanceUIGraphCachedValueOptions valueOptions, DanceUIGraphAttribute attribute, DanceUIGraphChangedValueFlags *changedValueFlags, DanceUIGraphTypeIndex (*body)(void *ctx SWIFT_CONTEXT, DanceUIGraphContextRef) SWIFT_CC(swift), const void *bodyContext) SWIFT_CC(swift);
const void * _Nullable OAGDanceUIGraphReadCachedAttributeIfExists(uintptr_t hashValue, const DanceUIGraphSwiftMetadata *selfMetadata, const void *attributeBody, const DanceUIGraphSwiftMetadata *valueMetadata, DanceUIGraphCachedValueOptions valueOptions, DanceUIGraphAttribute attribute, DanceUIGraphChangedValueFlags *changedValueFlags) SWIFT_CC(swift);

void OAGDanceUISubgraphSetCurrent(DanceUISubgraphRef _Nullable subgraph) SWIFT_CC(swift);
DanceUISubgraphRef _Nullable OAGDanceUISubgraphGetCurrent(void) SWIFT_CC(swift);
DanceUIGraphContextRef _Nullable OAGDanceUISubgraphGetCurrentGraphContext(void) SWIFT_CC(swift);
void OAGDanceUISubgraphApply(DanceUISubgraphRef subgraph, DanceUIGraphAttributeFlags flags, void (*applyBody)(void *ctx SWIFT_CONTEXT, DanceUIGraphAttribute attribute) SWIFT_CC(swift), const void *applyBodyContext) SWIFT_CC(swift);
bool OAGDanceUISubgraphIntersects(DanceUISubgraphRef subgraph, DanceUIGraphAttributeFlags flags) SWIFT_CC(swift);

DANCE_UI_ASSUME_NONNULL_END

#endif

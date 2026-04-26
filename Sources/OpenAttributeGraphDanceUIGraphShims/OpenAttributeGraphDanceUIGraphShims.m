#include <OpenAttributeGraphDanceUIGraphShims/OpenAttributeGraphDanceUIGraphShims.h>

void * _Nullable OAGDanceUIGraphGetContext(DanceUIGraphRef graph) SWIFT_CC(swift) {
    return DanceUIGraphGetContext(graph);
}

void OAGDanceUIGraphSetContext(DanceUIGraphRef graph, void * _Nullable context) SWIFT_CC(swift) {
    DanceUIGraphSetContext(graph, context);
}

DanceUIGraphAttribute OAGDanceUIGraphGetCurrentAttribute(void) SWIFT_CC(swift) {
    return DanceUIGraphGetCurrentAttribute();
}

bool OAGDanceUIGraphCurrentAttributeWasModified(void) SWIFT_CC(swift) {
    return DanceUIGraphCurrentAttributeWasModified();
}

DanceUIGraphAttribute OAGDanceUIGraphCurrentAttributeUpdatedReason(void) SWIFT_CC(swift) {
    return DanceUIGraphCurrentAttributeUpdatedReason();
}

void *OAGDanceUIGraphClearUpdate(void) SWIFT_CC(swift) {
    return DanceUIGraphClearUpdate();
}

void OAGDanceUIGraphSetUpdate(void *update) SWIFT_CC(swift) {
    DanceUIGraphSetUpdate(update);
}

DanceUIGraphAttribute OAGDanceUIGraphCreateAttribute(DanceUIGraphTypeIndex typeID, const void *attribute, const void * _Nullable value) SWIFT_CC(swift) {
    return DanceUIGraphCreateAttribute(typeID, (void *)attribute, (void *)value);
}

DanceUIGraphValue OAGDanceUIGraphGetValue(DanceUIGraphAttribute attribute, DanceUIGraphInputOptions options, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift) {
    return DanceUIGraphGetValue(attribute, (DanceUIGraphValueOptions)options, metadata);
}

bool OAGDanceUIGraphSetValue(DanceUIGraphAttribute attribute, const void *value, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift) {
    return DanceUIGraphSetValue(attribute, value, metadata);
}

DanceUIGraphValue OAGDanceUIGraphGetInputValue(DanceUIGraphAttribute destinationAttribute, DanceUIGraphAttribute inputAttribute, DanceUIGraphInputOptions options, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift) {
    return DanceUIGraphGetInputValue(destinationAttribute, inputAttribute, (DanceUIGraphValueOptions)options, metadata);
}

const void * _Nullable OAGDanceUIGraphGetOutputValue(const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift) {
    return DanceUIGraphGetOutputValue(metadata);
}

void OAGDanceUIGraphSetOutputValue(const void *value, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift) {
    DanceUIGraphSetOutputValue((void *)value, metadata);
}

void OAGDanceUIGraphWithUpdate(DanceUIGraphAttribute attribute, void (*updateCallback)(void *ctx SWIFT_CONTEXT) SWIFT_CC(swift), const void *updateCallbackContext) SWIFT_CC(swift) {
    DanceUIGraphWithUpdate(attribute, updateCallback, updateCallbackContext);
}

DanceUIGraphAttribute OAGDanceUIGraphCreateOffsetAttribute(DanceUIGraphAttribute attribute, int offset) SWIFT_CC(swift) {
    return DanceUIGraphCreateOffsetAttribute(attribute, (uint32_t)offset);
}

DanceUIGraphAttribute OAGDanceUIGraphCreateOffsetAttribute2(DanceUIGraphAttribute attribute, int offset, int size) SWIFT_CC(swift) {
    return DanceUIGraphCreateOffsetAttribute2(attribute, (uint32_t)offset, (uint32_t)size);
}

DanceUIGraphAttribute OAGDanceUIGraphCreateIndirectAttribute(DanceUIGraphAttribute attribute) SWIFT_CC(swift) {
    return DanceUIGraphCreateIndirectAttribute(attribute);
}

DanceUIGraphAttribute OAGDanceUIGraphCreateIndirectAttribute2(DanceUIGraphAttribute attribute, uint32_t size) SWIFT_CC(swift) {
    return DanceUIGraphCreateIndirectAttribute2(attribute, size);
}

DanceUIGraphAttribute OAGDanceUIGraphGetIndirectAttribute(DanceUIGraphAttribute attribute) SWIFT_CC(swift) {
    return DanceUIGraphGetIndirectAttribute(attribute);
}

void OAGDanceUIGraphSetIndirectAttribute(DanceUIGraphAttribute attribute, DanceUIGraphAttribute source) SWIFT_CC(swift) {
    DanceUIGraphSetIndirectAttribute(attribute, source);
}

DanceUIGraphAttribute OAGDanceUIGraphGetIndirectDependency(DanceUIGraphAttribute attribute) SWIFT_CC(swift) {
    return DanceUIGraphGetIndirectDependency(attribute);
}

void OAGDanceUIGraphSetIndirectDependency(DanceUIGraphAttribute attribute, DanceUIGraphAttribute dependency) SWIFT_CC(swift) {
    DanceUIGraphSetIndirectDependency(attribute, dependency);
}

DanceUIGraphWeakAttribute OAGDanceUIGraphCreateWeakAttribute(DanceUIGraphAttribute attribute) SWIFT_CC(swift) {
    return DanceUIGraphCreateWeakAttribute(attribute);
}

DanceUIGraphAttribute OAGDanceUIGraphWeakAttributeGetAttribute(DanceUIGraphWeakAttribute weakAttribute) SWIFT_CC(swift) {
    return DanceUIGraphWeakAttributeGetAttribute(weakAttribute);
}

DanceUIGraphWeakValue OAGDanceUIGraphGetWeakValue(DanceUIGraphWeakAttribute weakAttribute, DanceUIGraphInputOptions options, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift) {
    return DanceUIGraphGetWeakValue(weakAttribute, (DanceUIGraphValueOptions)options, metadata);
}

DanceUIGraphAttributeInfo OAGDanceUIGraphGetAttributeInfo(DanceUIGraphAttribute attribute) SWIFT_CC(swift) {
    return DanceUIGraphGetAttributeInfo(attribute);
}

void OAGDanceUIGraphMutateAttribute(DanceUIGraphAttribute attribute, const DanceUIGraphSwiftMetadata *metadata, bool invalidate, void (*mutateBody)(void *ctx SWIFT_CONTEXT, void *attribute) SWIFT_CC(swift), const void *mutateBodyContext) SWIFT_CC(swift) {
    DanceUIGraphMutateAttribute(attribute, metadata, invalidate, mutateBody, mutateBodyContext);
}

void OAGDanceUIGraphVerifyType(DanceUIGraphAttribute attribute, const DanceUIGraphSwiftMetadata *metadata) SWIFT_CC(swift) {
    DanceUIGraphVerifyType(attribute, metadata);
}

void OAGDanceUIGraphAddInput(DanceUIGraphAttribute toAttribute, DanceUIGraphAttribute fromAttribute, DanceUIGraphInputOptions inputOptions) SWIFT_CC(swift) {
    DanceUIGraphAddInput(toAttribute, fromAttribute, inputOptions);
}

void OAGDanceUIGraphInvalidateAllValues(DanceUIGraphRef graph) SWIFT_CC(swift) {
    DanceUIGraphInvalidateAllValues(graph);
}

void OAGDanceUIGraphInvalidateValue(DanceUIGraphAttribute attribute) SWIFT_CC(swift) {
    DanceUIGraphInvalidateValue(attribute);
}

bool OAGDanceUIGraphHasValue(DanceUIGraphAttribute attribute) SWIFT_CC(swift) {
    return DanceUIGraphHasValue(attribute);
}

void OAGDanceUIGraphUpdateValue(DanceUIGraphAttribute attribute) SWIFT_CC(swift) {
    DanceUIGraphUpdateValue(attribute);
}

DanceUIGraphValueState OAGDanceUIGraphGetValueState(DanceUIGraphAttribute attribute) SWIFT_CC(swift) {
    return DanceUIGraphGetValueState(attribute);
}

bool OAGDanceUIGraphSearch(DanceUIGraphAttribute rootAttribute, DanceUIGraphSearchOptions options, bool (*body)(void *ctx SWIFT_CONTEXT, DanceUIGraphAttribute attribute) SWIFT_CC(swift), const void *bodyContext) SWIFT_CC(swift) {
    return DanceUIGraphSearch(rootAttribute, options, body, bodyContext);
}

DanceUIGraphAttributeFlags OAGDanceUIGraphGetFlags(DanceUIGraphAttribute attribute) SWIFT_CC(swift) {
    return DanceUIGraphGetFlags(attribute);
}

void OAGDanceUIGraphSetFlags(DanceUIGraphAttribute attribute, DanceUIGraphAttributeFlags flags) SWIFT_CC(swift) {
    DanceUIGraphSetFlags(attribute, flags);
}

const void *OAGDanceUIGraphReadCachedAttribute(uintptr_t hashValue, const DanceUIGraphSwiftMetadata *selfMetadata, const void *attributeBody, const DanceUIGraphSwiftMetadata *valueMetadata, DanceUIGraphCachedValueOptions valueOptions, DanceUIGraphAttribute attribute, DanceUIGraphChangedValueFlags *changedValueFlags, DanceUIGraphTypeIndex (*body)(void *ctx SWIFT_CONTEXT, DanceUIGraphContextRef) SWIFT_CC(swift), const void *bodyContext) SWIFT_CC(swift) {
    return DanceUIGraphReadCachedAttribute(hashValue, selfMetadata, attributeBody, valueMetadata, valueOptions, attribute, changedValueFlags, body, bodyContext);
}

const void * _Nullable OAGDanceUIGraphReadCachedAttributeIfExists(uintptr_t hashValue, const DanceUIGraphSwiftMetadata *selfMetadata, const void *attributeBody, const DanceUIGraphSwiftMetadata *valueMetadata, DanceUIGraphCachedValueOptions valueOptions, DanceUIGraphAttribute attribute, DanceUIGraphChangedValueFlags *changedValueFlags) SWIFT_CC(swift) {
    return DanceUIGraphReadCachedAttributeIfExists(hashValue, selfMetadata, attributeBody, valueMetadata, valueOptions, attribute, changedValueFlags);
}

void OAGDanceUISubgraphSetCurrent(DanceUISubgraphRef _Nullable subgraph) SWIFT_CC(swift) {
    DanceUISubgraphSetCurrent(subgraph);
}

DanceUISubgraphRef _Nullable OAGDanceUISubgraphGetCurrent(void) SWIFT_CC(swift) {
    return DanceUISubgraphGetCurrent();
}

DanceUIGraphContextRef _Nullable OAGDanceUISubgraphGetCurrentGraphContext(void) SWIFT_CC(swift) {
    return DanceUISubgraphGetCurrentGraphContext();
}

void OAGDanceUISubgraphApply(DanceUISubgraphRef subgraph, DanceUIGraphAttributeFlags flags, void (*applyBody)(void *ctx SWIFT_CONTEXT, DanceUIGraphAttribute attribute) SWIFT_CC(swift), const void *applyBodyContext) SWIFT_CC(swift) {
    DanceUISubgraphApply(subgraph, flags, applyBody, applyBodyContext);
}

bool OAGDanceUISubgraphIntersects(DanceUISubgraphRef subgraph, DanceUIGraphAttributeFlags flags) SWIFT_CC(swift) {
    return DanceUISubgraphIntersects(subgraph, flags);
}

//
//  OGGraph.h
//  OpenGraph_SPI

#ifndef OGGraph_h
#define OGGraph_h

#include "OGBase.h"
#include "../Private/CFRuntime.h"
#include "OGCounterQueryType.h"

// Note: Place all structure declaration in a single place to avoid header cycle dependency

typedef struct OG_BRIDGED_TYPE(id) OGGraphStorage * OGGraphRef OG_SWIFT_NAME(Graph);
typedef struct OG_BRIDGED_TYPE(id) OGSubgraphStorage * OGSubgraphRef OG_SWIFT_NAME(Subgraph);
typedef struct OG_BRIDGED_TYPE(id) OGGraphContextStorage * OGGraphContextRef OG_SWIFT_NAME(GraphContext);

struct OGGraphStorage;
struct OGGraphContextStorage;
struct OGSubgraphStorage;

typedef uint32_t OGAttribute OG_SWIFT_STRUCT OG_SWIFT_NAME(AnyAttribute);

OG_ASSUME_NONNULL_BEGIN

// MARK: - Exported C functions

OG_EXTERN_C_BEGIN

OG_EXPORT
OG_REFINED_FOR_SWIFT
OGGraphRef OGGraphCreate(void) OG_SWIFT_NAME(OGGraphRef.init());

OG_EXPORT
OG_REFINED_FOR_SWIFT
OGGraphRef OGGraphCreateShared(_Nullable OGGraphRef graph) OG_SWIFT_NAME(OGGraphRef.init(shared:));

OG_EXPORT
OG_REFINED_FOR_SWIFT
void OGGraphArchiveJSON(char const * _Nullable name) OG_SWIFT_NAME(OGGraphRef.archiveJSON(name:));

OG_EXPORT
OG_REFINED_FOR_SWIFT
_Nullable CFTypeRef OGGraphDescription(_Nullable OGGraphRef graph, CFDictionaryRef options) OG_SWIFT_NAME(OGGraphRef.description(_:options:));

OG_EXPORT
OG_REFINED_FOR_SWIFT
CFTypeID OGGraphGetTypeID(void) OG_SWIFT_NAME(getter:OGGraphRef.typeID());

OG_EXPORT
OG_REFINED_FOR_SWIFT
void OGGraphStartProfiling(_Nullable OGGraphRef graph);

OG_EXPORT
OG_REFINED_FOR_SWIFT
void OGGraphStopProfiling(_Nullable OGGraphRef graph);

OG_EXPORT
OG_REFINED_FOR_SWIFT
const void * _Nullable OGGraphGetContext(OGGraphRef graph) OG_SWIFT_NAME(getter:OGGraphRef.context(self:));

OG_EXPORT
OG_REFINED_FOR_SWIFT
void OGGraphSetContext(OGGraphRef graph, const void * _Nullable context) OG_SWIFT_NAME(setter:OGGraphRef.context(self:_:));

OG_EXPORT
OG_REFINED_FOR_SWIFT
OGGraphContextRef OGGraphGetGraphContext(OGGraphRef graph) OG_SWIFT_NAME(getter:OGGraphRef.graphContext(self:));

OG_EXPORT
OG_REFINED_FOR_SWIFT
void OGGraphInvalidate(OGGraphRef graph) OG_SWIFT_NAME(OGGraphRef.invalidate(self:));

OG_EXPORT
OG_REFINED_FOR_SWIFT
void OGGraphInvalidateAllValues(OGGraphRef graph) OG_SWIFT_NAME(OGGraphRef.invalidateAllValues(self:));

OG_EXPORT
OG_REFINED_FOR_SWIFT
void OGGraphSetInvalidationCallback(OGGraphRef graph,
                                    const void (*_Nullable function)(const void * _Nullable context OG_SWIFT_CONTEXT, OGAttribute) OG_SWIFT_CC(swift),
                                    const void * _Nullable context);

OG_EXPORT
OG_REFINED_FOR_SWIFT
void OGGraphSetUpdateCallback(OGGraphRef graph,
                               const void (*_Nullable function)(const void * _Nullable context OG_SWIFT_CONTEXT) OG_SWIFT_CC(swift),
                               const void * _Nullable context);

OG_EXPORT
OG_REFINED_FOR_SWIFT
uint64_t OGGraphGetCounter(OGGraphRef graph, OGCounterQueryType query) OG_SWIFT_NAME(OGGraphRef.counter(self:for:));

OG_EXPORT
OG_REFINED_FOR_SWIFT
void OGGraphSetUpdate(const void * _Nullable value) OG_SWIFT_NAME(OGGraphRef.setUpdate(_:));

OG_EXPORT
OG_REFINED_FOR_SWIFT
const void * _Nullable OGGraphClearUpdate(void) OG_SWIFT_NAME(OGGraphRef.clearUpdate());

OG_EXPORT
OG_REFINED_FOR_SWIFT
void OGGraphSetNeedsUpdate(OGGraphRef graph) OG_SWIFT_NAME(OGGraphRef.setNeedsUpdate(self:));

OG_EXPORT
OG_REFINED_FOR_SWIFT
bool OGGraphAnyInputsChanged(const OGAttribute *inputs OG_COUNTED_BY(count), size_t count);

OG_EXTERN_C_END

OG_ASSUME_NONNULL_END

#endif /* OGGraph_h */

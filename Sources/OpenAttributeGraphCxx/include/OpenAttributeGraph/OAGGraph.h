//
//  OAGGraph.h
//  OpenAttributeGraphCxx

#ifndef OAGGraph_h
#define OAGGraph_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/Private/CFRuntime.h>
#include <OpenAttributeGraph/OAGGraphCounterQueryType.h>

// Note: Place all structure declaration in a single place to avoid header cycle dependency

typedef struct OAG_BRIDGED_TYPE(id) OAGGraphStorage * OAGGraphRef OAG_SWIFT_NAME(Graph);
typedef struct OAG_BRIDGED_TYPE(id) OAGSubgraphStorage * OAGSubgraphRef OAG_SWIFT_NAME(Subgraph);
typedef struct OAG_BRIDGED_TYPE(id) OAGGraphContextStorage * OAGGraphContextRef OAG_SWIFT_NAME(GraphContext);

struct OAGGraphStorage;
struct OAGGraphContextStorage;
struct OAGSubgraphStorage;

typedef uint32_t OAGAttribute OAG_SWIFT_STRUCT OAG_SWIFT_NAME(AnyAttribute);

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

// MARK: - Exported C functions

OAG_EXTERN_C_BEGIN

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGGraphRef OAGGraphCreate(void) OAG_SWIFT_NAME(OAGGraphRef.init());

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGGraphRef OAGGraphCreateShared(_Nullable OAGGraphRef graph) OAG_SWIFT_NAME(OAGGraphRef.init(shared:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
CFTypeID OAGGraphGetTypeID(void) OAG_SWIFT_NAME(getter:OAGGraphRef.typeID());

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphStartProfiling(_Nullable OAGGraphRef graph);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphStopProfiling(_Nullable OAGGraphRef graph);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphResetProfile(_Nullable OAGGraphRef graph);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const void * _Nullable OAGGraphGetContext(OAGGraphRef graph) OAG_SWIFT_NAME(getter:OAGGraphRef.context(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphSetContext(OAGGraphRef graph, const void * _Nullable context) OAG_SWIFT_NAME(setter:OAGGraphRef.context(self:_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGGraphContextRef OAGGraphGetGraphContext(OAGGraphRef graph) OAG_SWIFT_NAME(getter:OAGGraphRef.graphContext(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphInvalidate(OAGGraphRef graph) OAG_SWIFT_NAME(OAGGraphRef.invalidate(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphInvalidateAllValues(OAGGraphRef graph) OAG_SWIFT_NAME(OAGGraphRef.invalidateAllValues(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphSetInvalidationCallback(OAGGraphRef graph,
                                    const void (*_Nullable function)(const void * _Nullable context OAG_SWIFT_CONTEXT, OAGAttribute) OAG_SWIFT_CC(swift),
                                    const void * _Nullable context);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphSetUpdateCallback(OAGGraphRef graph,
                               const void (*_Nullable function)(const void * _Nullable context OAG_SWIFT_CONTEXT) OAG_SWIFT_CC(swift),
                               const void * _Nullable context);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
uint64_t OAGGraphGetCounter(OAGGraphRef graph, OAGGraphCounterQueryType query) OAG_SWIFT_NAME(OAGGraphRef.counter(self:for:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphSetUpdate(const void * _Nullable value) OAG_SWIFT_NAME(OAGGraphRef.setUpdate(_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const void * _Nullable OAGGraphClearUpdate(void) OAG_SWIFT_NAME(OAGGraphRef.clearUpdate());

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphSetNeedsUpdate(OAGGraphRef graph) OAG_SWIFT_NAME(OAGGraphRef.setNeedsUpdate(self:));

#if OAG_TARGET_OS_DARWIN
OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGGraphAnyInputsChanged(const OAGAttribute *excluded_inputs OAG_COUNTED_BY(count), size_t count);
#else
// __counted_by__ is supported with Swift 6.1+ toolchain's clang on Linux.
// But it required the count to be declared first which is not required on Apple clang.
// See https://github.com/OpenSwiftUIProject/OpenAttributeGraph/issues/130
OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGGraphAnyInputsChanged(const OAGAttribute *excluded_inputs, size_t count);
#endif

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGGraph_h */

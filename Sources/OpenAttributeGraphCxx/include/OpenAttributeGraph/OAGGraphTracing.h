//
//  OAGGraphTracing.h
//  OpenAttributeGraphCxx

#ifndef OAGGraphTracing_hpp
#define OAGGraphTracing_hpp

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGGraph.h>
#include <OpenAttributeGraph/OAGUniqueID.h>

typedef OAG_OPTIONS(uint32_t, OAGGraphTraceOptions) {
    OAGGraphTraceOptionsEnabled = 1 << 0,
    OAGGraphTraceOptionsFull = 1 << 1,
    OAGGraphTraceOptionsBacktrace = 1 << 2,
    OAGGraphTraceOptionsPrepare = 1 << 3,
    OAGGraphTraceOptionsCustom = 1 << 4,
    OAGGraphTraceOptionsAll = 1 << 5,
} OAG_SWIFT_NAME(OAGGraphRef.TraceOptions);

typedef struct OAGTrace *OAGTraceRef;

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

OAG_EXTERN_C_BEGIN

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphStartTracing(_Nullable OAGGraphRef graph, OAGGraphTraceOptions options) OAG_SWIFT_NAME(OAGGraphRef.startTracing(_:options:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphStartTracing2(_Nullable OAGGraphRef graph, OAGGraphTraceOptions options, _Nullable CFArrayRef subsystems) OAG_SWIFT_NAME(OAGGraphRef.startTracing(_:flags:subsystems:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphStopTracing(_Nullable OAGGraphRef graph) OAG_SWIFT_NAME(OAGGraphRef.stopTracing(_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphSyncTracing(_Nullable OAGGraphRef graph) OAG_SWIFT_NAME(OAGGraphRef.syncTracing(_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
CFStringRef OAGGraphCopyTracePath(_Nullable OAGGraphRef graph) OAG_SWIFT_NAME(OAGGraphRef.tracePath(_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGUniqueID OAGGraphAddTrace(OAGGraphRef graph, const OAGTraceRef trace, void *_Nullable context) OAG_SWIFT_NAME(OAGGraphRef.addTrace(self:_:context:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphRemoveTrace(OAGGraphRef graph, OAGUniqueID trace_id) OAG_SWIFT_NAME(OAGGraphRef.removeTrace(self:traceID:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphSetTrace(OAGGraphRef graph, const OAGTraceRef trace, void *_Nullable context) OAG_SWIFT_NAME(OAGGraphRef.setTrace(self:_:context:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphResetTrace(OAGGraphRef graph) OAG_SWIFT_NAME(OAGGraphRef.resetTrace(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGGraphIsTracingActive(OAGGraphRef graph) OAG_SWIFT_NAME(getter:OAGGraphRef.isTracingActive(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const char *_Nullable OAGGraphGetTraceEventName(uint32_t event_id) OAG_SWIFT_NAME(OAGGraphRef.traceEventName(for:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const char *_Nullable OAGGraphGetTraceEventSubsystem(uint32_t event_id) OAG_SWIFT_NAME(OAGGraphRef.traceEventSubsystem(for:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
uint32_t OAGGraphRegisterNamedTraceEvent(const char *event_name, const char *event_subsystem) OAG_SWIFT_NAME(OAGGraphRef.registerNamedTraceEvent(name:subsystem:));

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGGraphTracing_hpp */

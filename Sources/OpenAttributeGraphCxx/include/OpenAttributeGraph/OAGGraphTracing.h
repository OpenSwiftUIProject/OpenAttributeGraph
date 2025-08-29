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
OAGUniqueID OAGGraphAddTrace(OAGGraphRef graph, const OAGTraceRef trace, void *_Nullable context)
OAG_SWIFT_NAME(OAGGraphRef.addTrace(self:_:context:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphRemoveTrace(OAGGraphRef graph, OAGUniqueID trace_id) OAG_SWIFT_NAME(OAGGraphRef.removeTrace(self:traceID:));

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGGraphTracing_hpp */

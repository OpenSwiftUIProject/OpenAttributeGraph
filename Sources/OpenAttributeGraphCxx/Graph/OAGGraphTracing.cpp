//
//  OAGGraphTracing.mm
//  OpenAttributeGraphCxx

#include <OpenAttributeGraph/OAGGraphTracing.h>

void OAGGraphStartTracing(_Nullable OAGGraphRef graph, OAGGraphTraceOptions options) {
    OAGGraphStartTracing2(graph, options, NULL);
}

void OAGGraphStartTracing2(_Nullable OAGGraphRef graph, OAGGraphTraceOptions options, _Nullable CFArrayRef array) {
    // TODO
}

void OAGGraphStopTracing(_Nullable OAGGraphRef graph) {
    // TODO
}

void OAGGraphSyncTracing(_Nullable OAGGraphRef graph) {
    // TODO
}

CFStringRef OAGGraphCopyTracePath(_Nullable OAGGraphRef graph) {
    // TODO
    return nullptr;
}

OAGUniqueID OAGGraphAddTrace(OAGGraphRef graph, const OAGTraceRef trace, void *context) {
    // TODO
    return 0;
}

void OAGGraphRemoveTrace(OAGGraphRef graph, OAGUniqueID trace_id) {
    // TODO
}

void OAGGraphSetTrace(OAGGraphRef graph, const OAGTraceRef trace, void *context) {
    // TODO
}

void OAGGraphResetTrace(OAGGraphRef graph) {
    // TODO
}

bool OAGGraphIsTracingActive(OAGGraphRef graph) {
    // TODO
    return false;
}

const char *OAGGraphGetTraceEventName(uint32_t event_id) {
    // TODO
    return nullptr;
}

const char *OAGGraphGetTraceEventSubsystem(uint32_t event_id) {
    // TODO
    return nullptr;
}

uint32_t OAGGraphRegisterNamedTraceEvent(const char *event_name, const char *event_subsystem) {
    // TODO
    return 0;
}

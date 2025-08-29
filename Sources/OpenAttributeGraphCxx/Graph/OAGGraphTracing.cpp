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

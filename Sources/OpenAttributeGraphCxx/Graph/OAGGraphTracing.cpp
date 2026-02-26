//
//  OAGGraphTracing.mm
//  OpenAttributeGraphCxx

#include <OpenAttributeGraph/OAGGraphTracing.h>
#include <OpenAttributeGraphCxx/Graph/Graph.hpp>

namespace OAG {
void Graph::trace_assertion_failure(bool remove, const char *format, ...) OAG_NOEXCEPT {
    // TODO
}
} /* OAG */

void OAGGraphStartTracing(_Nullable OAGGraphRef graph, OAGGraphTraceOptions options) {
    OAGGraphStartTracing2(graph, options, NULL);
}

void OAGGraphStartTracing2(_Nullable OAGGraphRef graph, OAGGraphTraceOptions options, _Nullable CFArrayRef array) {
    // TODO
}

void OAGGraphStopTracing(_Nullable OAGGraphRef graph) {
    // TODO
}

//
//  GraphDescription.cpp
//  OpenAttributeGraphCxx

#include <OpenAttributeGraph/OAGGraphDescription.h>
#include <OpenAttributeGraph/OAGGraph.h>
#include <OpenAttributeGraphCxx/Graph/Graph.hpp>
#include <OpenAttributeGraphCxx/Misc/assert.hpp>

CFTypeRef OAGGraphDescription(OAGGraphRef graph, CFDictionaryRef options) {
    #if OAG_OBJC_FOUNDATION
    if (graph == nullptr) {
        return OAG::Graph::description(nullptr, (__bridge NSDictionary*)options);
    }
    if (graph->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    return OAG::Graph::description(&graph->context.get_graph(), (__bridge NSDictionary*)options);
    #endif
}

void OAGGraphArchiveJSON(char const * _Nullable name) {
    #if OAG_OBJC_FOUNDATION
    OAG::Graph::write_to_file(nullptr, name, 0);
    #endif
}

void OAGGraphArchiveJSON2(char const * _Nullable name, uint8_t options) {
    #if OAG_OBJC_FOUNDATION
    OAG::Graph::write_to_file(nullptr, name, options);
    #endif
}


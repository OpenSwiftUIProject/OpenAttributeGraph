//
//  GraphDescription.mm
//  OpenAttributeGraphCxx

#include <OpenAttributeGraph/OAGGraphDescription.h>
#include <OpenAttributeGraph/OAGGraph.h>
#include <OpenAttributeGraphCxx/Graph/Graph.hpp>
#include <OpenAttributeGraphCxx/Misc/assert.hpp>

#if OAG_OBJC_FOUNDATION

#include <Foundation/Foundation.h>

const CFStringRef OAGDescriptionFormat = CFSTR("format");
const CFStringRef OAGDescriptionIncludeValues = CFSTR("include-values");

CFTypeRef OAG::Graph::description(const Graph * _Nullable graph, NSDictionary* dic) {
    // TODO
    // For "format": "graph/dict" - NSMutableDictionray
    // For "format": "graph/dot" - NSMutableString
    return NULL;
}

#endif /* OAG_OBJC_FOUNDATION */

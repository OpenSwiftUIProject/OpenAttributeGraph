//
//  OAGGraphContext.cpp
//  OpenAttributeGraphCxx

#include <OpenAttributeGraph/OAGGraphContext.h>
#include <OpenAttributeGraph/Private/CFRuntime.h>

OAGGraphRef OAGGraphContextGetGraph(OAGGraphContextRef context) {
    return reinterpret_cast<OAGGraphRef>(reinterpret_cast<uintptr_t>(context) - sizeof(CFRuntimeBase));
}

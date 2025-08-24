//
//  OAGSubgraph.cpp
//  OpenAttributeGraphCxx

#include <OpenAttributeGraph/OAGSubgraph.h>
#include <OpenAttributeGraph/OAGGraph.h>
#include <OpenAttributeGraphCxx/Graph/Subgraph.hpp>
#include <OpenAttributeGraph/OAGGraphContext.h>
#include <OpenAttributeGraphCxx/Misc/assert.hpp>
#include <OpenAttributeGraphCxx/Misc/env.hpp>
#include <pthread.h>
#if !OAG_TARGET_OS_WASI
#include <dispatch/dispatch.h>
#endif

namespace {
CFRuntimeClass &subgraph_type_id() {
    static auto dealloc = [](const void* ptr) {
        OAGSubgraphRef storage = (OAGSubgraphRef)ptr;
        auto subgraph = storage->subgraph;
        if (subgraph == nullptr) {
            return;
        }
        subgraph->clear_object();
        subgraph->invalidate_and_delete_(false);
    };
    static CFRuntimeClass klass = {
        0,
        "OAGSubgraph",
        NULL,   // init
        NULL,   // copy
        dealloc,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        0,
    };
    return klass;
}
}

CFTypeID OAGSubgraphGetTypeID() {
    static CFTypeID type = _CFRuntimeRegisterClass(&subgraph_type_id());
    return type;
}

OAGSubgraphRef OAGSubgraphCreate(OAGGraphRef cf_graph) {
    return OAGSubgraphCreate2(cf_graph, OAGAttributeNil);
}

OAGSubgraphRef OAGSubgraphCreate2(OAGGraphRef cf_graph, OAGAttribute attribute) {
    OAG::Graph::Context &context = OAG::Graph::Context::from_cf(cf_graph);
    const CFIndex extraSize = sizeof(OAGSubgraphStorage)-sizeof(CFRuntimeBase);
    #if OAG_TARGET_CPU_WASM32
    // FIXME: extraSize will always be 8 thus it will fail on WASM. Investate later.
    static_assert(extraSize == 8);
    #else
    static_assert(extraSize == sizeof(void *));
    #endif
    OAGSubgraphRef cf_subgrah = (OAGSubgraphRef)_CFRuntimeCreateInstance(kCFAllocatorDefault, OAGSubgraphGetTypeID(), extraSize, nullptr);
    if (cf_subgrah == nullptr) {
        OAG::precondition_failure("memory allocation failure.");
    }
    cf_subgrah->subgraph = new OAG::Subgraph((OAG::SubgraphObject *)cf_subgrah, context, attribute);
    return cf_subgrah;
}

_Nullable OAGSubgraphRef OAGSubgraphGetCurrent() {
    OAG::Subgraph *subgraph = OAG::Subgraph::get_current();
    if (subgraph == nullptr) {
        return nullptr;
    }
    return subgraph->to_cf();
}

void OAGSubgraphSetCurrent(_Nullable OAGSubgraphRef cf_subgraph) {
    OAG::Subgraph *old_subgraph = OAG::Subgraph::get_current();
    if (cf_subgraph == nullptr) {
        OAG::Subgraph::set_current(nullptr);
    } else {
        OAG::Subgraph *subgraph = cf_subgraph->subgraph;
        OAG::Subgraph::set_current(subgraph);
        if (subgraph != nullptr) {
            CFRetain(cf_subgraph);
        }
    }
    if (old_subgraph != nullptr) {
        OAGSubgraphRef old_cf_Subgraph = old_subgraph->to_cf();
        if (old_cf_Subgraph) {
            CFRelease(old_cf_Subgraph);
        }
    }
}

OAGGraphContextRef OAGSubgraphGetCurrentGraphContext() {
    OAG::Subgraph *subgraph = OAG::Subgraph::get_current();
    if (subgraph == nullptr) {
        return nullptr;
    }
    return subgraph->get_context();
}

void OAGSubgraphInvalidate(OAGSubgraphRef cf_subgraph) {
    if (cf_subgraph->subgraph == nullptr) {
        return;
    }
    cf_subgraph->subgraph->invalidate_and_delete_(false);
}

bool OAGSubgraphIsValid(OAGSubgraphRef cf_subgraph) {
    if (cf_subgraph->subgraph == nullptr) {
        return false;
    }
    return !cf_subgraph->subgraph->isInvalid();
}

OAGGraphRef OAGSubgraphGetGraph(OAGSubgraphRef cf_subgraph) {
    if (cf_subgraph->subgraph == nullptr) {
        OAG::precondition_failure("accessing invalidated subgraph");
    }
    return OAGGraphContextGetGraph(cf_subgraph->subgraph->get_context());
}

void OAGSubgraphAddChild(OAGSubgraphRef parent, OAGSubgraphRef child) {
    OAGSubgraphAddChild2(parent, child, 0);
}

void OAGSubgraphAddChild2(OAGSubgraphRef parent, OAGSubgraphRef child, uint8_t tag) {
    // TODO
}

void OAGSubgraphRemoveChild(OAGSubgraphRef parent, OAGSubgraphRef child) {
    // TODO
}

OAGSubgraphRef OAGSubgraphGetChild(OAGSubgraphRef cf_subgraph, uint32_t index, uint8_t *_Nullable tag_out) {
    // TODO
    return nullptr;
}

uint32_t OAGSubgraphGetChildCount(OAGSubgraphRef cf_subgraph) {
    // TODO
    return 0;
}

OAGSubgraphRef OAGSubgraphGetParent(OAGSubgraphRef cf_subgraph, int64_t index) {
    // TODO
    return nullptr;
}

uint64_t OAGSubgraphGetParentCount(OAGSubgraphRef cf_subgraph) {
    // TODO
    return 0;
}

bool OAGSubgraphIsAncestor(OAGSubgraphRef cf_subgraph, OAGSubgraphRef other) {
    // TODO
    return false;
}

void OAGSubgraphApply(OAGSubgraphRef cf_subgraph,
                     OAGAttributeFlags flags,
                     const void (*function)(const void * _Nullable context OAG_SWIFT_CONTEXT, OAGAttribute attribute) OAG_SWIFT_CC(swift),
                     const void * _Nullable context) {
    if (cf_subgraph->subgraph == nullptr) {
        return;
    }
    return cf_subgraph->subgraph->apply(flags, OAG::ClosureFunction<void, OAGAttribute>(function, context));
}

void OAGSubgraphUpdate(OAGSubgraphRef cf_subgraph, OAGAttributeFlags flags) {
    OAG::Subgraph *subgraph = cf_subgraph->subgraph;
    if (subgraph == nullptr) {
        return;
    }
    // subgraph->update(flags);
}

bool OAGSubgraphIsDirty(OAGSubgraphRef cf_subgraph, OAGAttributeFlags flags) {
    OAG::Subgraph *subgraph = cf_subgraph->subgraph;
    if (subgraph == nullptr) {
        return false;
    }
    // TODO
    return false;
}

OAGObserverID OAGSubgraphAddObserver(OAGSubgraphRef cf_subgraph,
                                 const void (*function)(const void * _Nullable context OAG_SWIFT_CONTEXT) OAG_SWIFT_CC(swift),
                                 const void * _Nullable context) {
    OAG::Subgraph *subgraph = cf_subgraph->subgraph;
    if (subgraph == nullptr) {
        OAG::precondition_failure("accessing invalidated subgraph");
    }
    return subgraph->add_observer(OAG::ClosureFunction<void>(function, context));
}

void OAGSubgraphRemoveObserver(OAGSubgraphRef cf_subgraph, OAGObserverID observerID) {
    OAG::Subgraph *subgraph = cf_subgraph->subgraph;
    if (subgraph == nullptr) {
        return;
    }
    subgraph->remove_observer(observerID);
}

#if !OAG_TARGET_OS_WASI
static bool should_record_tree;
static dispatch_once_t should_record_tree_once;

void init_should_record_tree(void * _Nullable context) {
    should_record_tree = OAG::get_env("OAG_TREE") != 0;
}
#endif

bool OAGSubgraphShouldRecordTree() {
    #if !OAG_TARGET_OS_WASI
    dispatch_once_f(&should_record_tree_once, NULL, init_should_record_tree);
    return should_record_tree;
    #else
    return false;
    #endif
}

void OAGSubgraphSetShouldRecordTree() {
    #if !OAG_TARGET_OS_WASI
    dispatch_once_f(&should_record_tree_once, NULL, init_should_record_tree);
    should_record_tree = true;
    #endif
}

void OAGSubgraphBeginTreeElement(OAGAttribute attribute, OAGTypeID type, uint32_t flags) {
    OAG::Subgraph * subgraph = OAG::Subgraph::get_current();
    if (subgraph) {
        subgraph->begin_tree(attribute, reinterpret_cast<OAG::swift::metadata const*>(type), flags);
    }
}

void OAGSubgraphAddTreeValue(OAGAttribute attribute, OAGTypeID type, const char * key, uint32_t flags) {
    OAG::Subgraph * subgraph = OAG::Subgraph::get_current();
    if (subgraph) {
        subgraph->add_tree_value(attribute, reinterpret_cast<OAG::swift::metadata const*>(type), key, flags);
    }
}

void OAGSubgraphEndTreeElement(OAGAttribute attribute) {
    OAG::Subgraph * subgraph = OAG::Subgraph::get_current();
    if (subgraph) {
        subgraph->end_tree(attribute);
    }
}

OAGTreeElement OAGSubgraphGetTreeRoot(OAGSubgraphRef cf_subgraph) {
    // TODO
    return nullptr;
}

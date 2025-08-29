//
//  OAGGraph.cpp
//  OpenAttributeGraphCxx

#include <OpenAttributeGraph/OAGGraph.h>
#include <OpenAttributeGraphCxx/Graph/Graph.hpp>
#include <OpenAttributeGraphCxx/Misc/assert.hpp>
#include <OpenAttributeGraphCxx/Data/ClosureFunction.hpp>
#include <pthread.h>

OAGGraphRef OAGGraphCreate() {
    return OAGGraphCreateShared(nullptr);
}

OAGGraphRef OAGGraphCreateShared(OAGGraphRef storage) {
    const CFIndex extraSize = sizeof(OAGGraphStorage)-sizeof(CFRuntimeBase);
    OAGGraphRef instance = (OAGGraphRef)_CFRuntimeCreateInstance(kCFAllocatorDefault, OAGGraphGetTypeID(), extraSize, nullptr);
    if (instance == nullptr) {
        OAG::precondition_failure("memory allocation failure.");
    }
    OAG::Graph *graph = nullptr;
    if (storage == nullptr) {
        graph = new OAG::Graph();
    } else {
        if (storage->context.isInvalid()) {
            OAG::precondition_failure("invalidated graph");
        }
        graph = &storage->context.get_graph();
        //  [graph+0x10c] += 1
    }
    // AG::Context(instance->graph, graph)
    
    //  [graph+0x10c] -= 1
//    if ([graph+0x10c] == 0) {
//        delete graph
//    }
    instance->context.setInvalid(false);
    return instance;
}

namespace {
CFRuntimeClass &graph_type_id() {
    static auto dealloc = [](const void* ptr) {
        OAGGraphRef storage = (OAGGraphRef)ptr;
        if (storage->context.isInvalid()) {
            return;
        }
        storage->context.~Context();
    };
    static CFRuntimeClass klass = {
        0,
        "OAGGraphStorage",
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

CFTypeID OAGGraphGetTypeID() {
    static CFTypeID type = _CFRuntimeRegisterClass(&graph_type_id());
    return type;
}

void OAGGraphStartProfiling(_Nullable OAGGraphRef graph) {
    if (!graph) {
        OAG::Graph::all_start_profiling(1);
        return;
    }
    if (graph->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    graph->context.get_graph().start_profiling(1);
}

void OAGGraphStopProfiling(_Nullable OAGGraphRef graph) {
    if (!graph) {
        OAG::Graph::all_stop_profiling();
        return;
    }
    if (graph->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    graph->context.get_graph().stop_profiling();
}

void OAGGraphResetProfile(_Nullable OAGGraphRef graph) {
    // TODO
}

const void * _Nullable OAGGraphGetContext(OAGGraphRef graph) {
    if (graph->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    return graph->context.get_context();
}

void OAGGraphSetContext(OAGGraphRef graph, const void * _Nullable context) {
    if (graph->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    graph->context.set_context(context);
}

OAGGraphContextRef OAGGraphGetGraphContext(OAGGraphRef graph) {
    if (graph->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    return reinterpret_cast<OAGGraphContextRef>(reinterpret_cast<uintptr_t>(graph) + sizeof(CFRuntimeBase));
}

void OAGGraphInvalidate(OAGGraphRef graph) {
    if (graph->context.isInvalid()) {
        return;
    }
    graph->context.~Context();
    graph->context.setInvalid(true);
}

void OAGGraphInvalidateAllValues(OAGGraphRef graph) {
    if (graph->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    graph->context.get_graph().value_mark_all();
}



void OAGGraphSetInvalidationCallback(OAGGraphRef graph,
                                    const void (*_Nullable function)(const void * _Nullable context OAG_SWIFT_CONTEXT, OAGAttribute) OAG_SWIFT_CC(swift),
                                    const void * _Nullable context) {
    if (graph->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    graph->context.set_invalidation_callback(OAG::ClosureFunction<void, OAGAttribute>(function, context));
}

void OAGGraphSetUpdateCallback(OAGGraphRef graph,
                               const void (*_Nullable function)(const void * _Nullable context OAG_SWIFT_CONTEXT) OAG_SWIFT_CC(swift),
                               const void * _Nullable context) {
    if (graph->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    graph->context.set_update_callback(OAG::ClosureFunction<void>(function, context));
}

uint64_t OAGGraphGetCounter(OAGGraphRef graph, OAGGraphCounterQueryType query) {
    if (graph->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    OAG::Graph::Context& context = graph->context;
    switch (query) {
        case OAGGraphCounterQueryTypeNodes:
            return context.get_graph().get_counter_0();
        case OAGGraphCounterQueryTypeTransactions:
            return context.get_graph().get_counter_1();
        case OAGGraphCounterQueryTypeUpdates:
            return context.get_graph().get_counter_2();
        case OAGGraphCounterQueryTypeChanges:
            return context.get_graph().get_counter_3();
        case OAGGraphCounterQueryTypeContextID:
            return context.get_graph().get_counter_4();
        case OAGGraphCounterQueryTypeGraphID:
            return context.get_graph().get_counter_5();
        case OAGGraphCounterQueryTypeContextThreadUpdating:
            return context.thread_is_updating();
        case OAGGraphCounterQueryTypeThreadUpdating:
            return context.get_graph().thread_is_updating();
        case OAGGraphCounterQueryTypeContextNeedsUpdate:
            return context.get_graph().get_counter_8();
        case OAGGraphCounterQueryTypeNeedsUpdate:
            return context.get_graph().get_counter_9();
        case OAGGraphCounterQueryTypeMainThreadUpdates:
            return context.get_graph().get_counter_10();
        default:
            return 0;
    }
}

void OAGGraphSetUpdate(const void * _Nullable value) {
    pthread_setspecific(OAG::Graph::current_key(), value);
}

const void * _Nullable OAGGraphClearUpdate(void) {
    void * value = pthread_getspecific(OAG::Graph::current_key());
    bool isDirty = (uint64_t)value & 0x1;
    if (value != nullptr && isDirty) {
        pthread_setspecific(OAG::Graph::current_key(), (void *)((uint64_t)value | 0x1));
    }
    return value;
}

void OAGGraphSetNeedsUpdate(OAGGraphRef graph) {
    if (graph->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    // graph->context->set_needs_update();
}

bool OAGGraphAnyInputsChanged(const OAGAttribute *excluded_inputs, size_t count) {
    // TODO
    return false;
}

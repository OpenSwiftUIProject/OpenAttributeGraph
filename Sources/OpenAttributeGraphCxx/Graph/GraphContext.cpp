//
//  GraphContext.cpp
//  OpenAttributeGraphCxx

#include <OpenAttributeGraphCxx/Graph/Graph.hpp>
#include <OpenAttributeGraph/OAGGraph.h>
#include <OpenAttributeGraphCxx/Misc/assert.hpp>

OAG::Graph::Context &OAG::Graph::Context::from_cf(OAGGraphRef storage) OAG_NOEXCEPT {
    if (storage->context.isInvalid()) {
        OAG::precondition_failure("invalidated graph");
    }
    return storage->context;
}

OAG::Graph::Context::Context(OAG::Graph &graph) OAG_NOEXCEPT :
_graph(&graph),
_context(nullptr),
_id(OAGMakeUniqueID()),
_invalidation_callback(nullptr),
_update_callback(nullptr) {
    // TODO
}

OAG::Graph::Context::~Context() OAG_NOEXCEPT {
    // TODO
}

const bool OAG::Graph::Context::thread_is_updating() const OAG_NOEXCEPT {
    return _graph->thread_is_updating() && _graph->is_context_updating(*this);
}

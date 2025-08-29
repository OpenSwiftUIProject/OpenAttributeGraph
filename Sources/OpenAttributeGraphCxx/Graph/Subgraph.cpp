//
//  Subgraph.cpp
//  OpenAttributeGraphCxx

#include <OpenAttributeGraphCxx/Graph/Subgraph.hpp>
#include <OpenAttributeGraph/OAGSubgraph.h>

pthread_key_t OAG::Subgraph::_current_subgraph_key;

OAG::Subgraph* OAG::Subgraph::from_cf(OAGSubgraphRef storage) OAG_NOEXCEPT {
    return storage->subgraph;
}

void OAG::Subgraph::clear_object() const OAG_NOEXCEPT {
    // TODO
}

void OAG::Subgraph::invalidate_and_delete_(bool) const OAG_NOEXCEPT {
    // TODO
}

void OAG::Subgraph::apply(OAGAttributeFlags flags, OAG::ClosureFunction<void, OAGAttribute> body) const OAG_NOEXCEPT {
    // TODO
}

OAG::Subgraph::Subgraph(OAG::SubgraphObject* cf_subgraph, OAG::Graph::Context& context, OAG::AttributeID):
_cf_subgraph((OAGSubgraphRef)cf_subgraph), // FIXME
_context((OAGGraphContextStorage &)context){
    // TODO
}

OAGUniqueID OAG::Subgraph::add_observer(OAG::ClosureFunction<void> observer) const OAG_NOEXCEPT {
    // TODO
    return OAGMakeUniqueID();
}

void OAG::Subgraph::begin_tree(OAG::AttributeID id, OAG::swift::metadata const* type, unsigned int flags) const OAG_NOEXCEPT {
    // TODO
}

void OAG::Subgraph::add_tree_value(OAG::AttributeID id, OAG::swift::metadata const *type, const char* key, uint32_t flags) const OAG_NOEXCEPT {
    // TODO
}

void OAG::Subgraph::end_tree(OAG::AttributeID id) const OAG_NOEXCEPT {
    // TODO
}

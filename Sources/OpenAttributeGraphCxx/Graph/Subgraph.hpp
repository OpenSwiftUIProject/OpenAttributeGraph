//
//  Subgraph.hpp
//  OpenAttributeGraphCxx

#ifndef Subgraph_hpp
#define Subgraph_hpp

#include "OAGBase.h"
#include <OpenAttributeGraphCxx/Graph/Graph.hpp>
#include <OpenAttributeGraphCxx/Attribute/AttributeID.hpp>
#include <OpenAttributeGraphCxx/Data/ClosureFunction.hpp>
#include <OpenAttributeGraphCxx/Runtime/metadata.hpp>
#include <pthread.h>

typedef struct OAG_BRIDGED_TYPE(id) OAGSubgraphStorage * OAGSubgraphRef;

namespace OAG {
class SubgraphObject;

class Subgraph final {
private:
    OAGSubgraphRef _cf_subgraph;
    OAGGraphContextStorage& _context;
    // TODO
    bool _isInvalid;
    static pthread_key_t _current_subgraph_key;
public:
    // MARK: - CF related
    
    static Subgraph *from_cf(OAGSubgraphRef cf_subgraph) OAG_NOEXCEPT;
    
    OAGSubgraphRef to_cf() const OAG_NOEXCEPT {
        return _cf_subgraph;
    }
    
    // MARK: - pthread related
    
    OAG_INLINE
    const static void make_current_subgraph_key() OAG_NOEXCEPT {
        pthread_key_create(&_current_subgraph_key, nullptr);
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const static pthread_key_t& current_key() OAG_NOEXCEPT {
        return _current_subgraph_key;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    static Subgraph *get_current() OAG_NOEXCEPT {
        return (OAG::Subgraph*)pthread_getspecific(OAG::Subgraph::current_key());
    }
    
    OAG_INLINE OAG_CONSTEXPR
    static int set_current(Subgraph *subgraph) OAG_NOEXCEPT {
        return pthread_setspecific(OAG::Subgraph::current_key(), subgraph);
    }
    
    // MARK: - Public API
    void clear_object() const OAG_NOEXCEPT;
    void invalidate_and_delete_(bool) const OAG_NOEXCEPT;
    
    void apply(OAGAttributeFlags flags, OAG::ClosureFunction<void, OAGAttribute> body) const OAG_NOEXCEPT;
    
    OAGUniqueID add_observer(OAG::ClosureFunction<void> observer) const OAG_NOEXCEPT;
    
    void begin_tree(OAG::AttributeID id, OAG::swift::metadata const *type, uint32_t flags) const OAG_NOEXCEPT;
    void add_tree_value(OAG::AttributeID id, OAG::swift::metadata const *type, const char* key, uint32_t flags) const OAG_NOEXCEPT;
    void end_tree(OAG::AttributeID id) const OAG_NOEXCEPT;

    // MARK: - Init and deinit
    
    Subgraph(SubgraphObject*, OAG::Graph::Context&, OAG::AttributeID);
    
    // MARK: - Getter and setter
    
    OAG_INLINE OAG_CONSTEXPR
    const OAGGraphContextRef get_context() const OAG_NOEXCEPT {
        return &_context;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    OAGGraphContextRef get_context() OAG_NOEXCEPT {
        return &_context;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const bool isInvalid() const OAG_NOEXCEPT {
        return _isInvalid;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    void setInvalid(bool invalid) OAG_NOEXCEPT {
        _isInvalid = invalid;
    }
}; /* Subgraph */
} /* OAG */

struct OAGSubgraphStorage {
    CFRuntimeBase base;
    OAG::Subgraph *subgraph;
};

namespace OAG {
class SubgraphObject final {
    OAGSubgraphStorage storage;
};
}

#endif /* Subgraph_hpp */

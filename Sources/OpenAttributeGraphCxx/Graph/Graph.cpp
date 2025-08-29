//
//  Graph.cpp
//  OpenAttributeGraphCxx

#include <OpenAttributeGraphCxx/Graph/Graph.hpp>
#include <OpenAttributeGraphCxx/Graph/Subgraph.hpp>
#include <OpenAttributeGraph/OAGGraphDescription.h>

#if !OAG_TARGET_OS_WASI
#include <dispatch/dispatch.h>
#endif

#include <pthread.h>

pthread_key_t OAG::Graph::_current_update_key;

OAG::Graph::Graph() OAG_NOEXCEPT {
    // TODO

    // libdispatch is not supported on WASI
    // Tracked via https://github.com/swiftwasm/swift/issues/5565
    #if !OAG_TARGET_OS_WASI
    static dispatch_once_t make_keys;
    dispatch_once_f(&make_keys, nullptr, [](void * _Nullable context){
        pthread_key_create(&_current_update_key, nullptr);
        OAG::Subgraph::make_current_subgraph_key();
    });
    #endif

    // TODO
}

const void OAG::Graph::value_mark_all() const OAG_NOEXCEPT {
    // TODO
}

void OAG::Graph::all_start_profiling(uint32_t) OAG_NOEXCEPT {
    // TODO
}
void OAG::Graph::all_stop_profiling() OAG_NOEXCEPT {
    // TODO
}
void OAG::Graph::start_profiling(uint32_t) OAG_NOEXCEPT {
    // TODO
}
void OAG::Graph::stop_profiling() OAG_NOEXCEPT {
    // TODO
}

const bool OAG::Graph::thread_is_updating() const OAG_NOEXCEPT {
    void *current = pthread_getspecific(current_key());
    if (!current) {
        return false;
    }
    // TODO
    return false;
}

const bool OAG::Graph::is_context_updating(const OAG::Graph::Context&) const OAG_NOEXCEPT {
    // TODO
    return false;
}

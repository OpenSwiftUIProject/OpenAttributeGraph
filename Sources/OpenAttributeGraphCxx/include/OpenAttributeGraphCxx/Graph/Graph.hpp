//
//  Graph.hpp
//  OpenAttributeGraphCxx


#ifndef Graph_hpp
#define Graph_hpp

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGGraph.h>
#include <OpenAttributeGraph/OAGUniqueID.h>
#include <OpenAttributeGraph/Private/CFRuntime.h>
#include <OpenAttributeGraphCxx/Data/ClosureFunction.hpp>

OAG_ASSUME_NONNULL_BEGIN

#if OAG_OBJC_FOUNDATION
@class NSDictionary;
#endif /* OAG_OBJC_FOUNDATION */

namespace OAG {
class Graph final {
public:
    class Context final {
    private:
        Graph * _Nullable _graph;
        const void * _Nullable _context;
        OAGUniqueID _id;
        ClosureFunction<void, OAGAttribute> _invalidation_callback;
        ClosureFunction<void> _update_callback;
        uint64_t unknown1;
        uint32_t unknown2;
        uint32_t unknown3;
        bool _isInvalid;
    public:
        static Context &from_cf(OAGGraphRef graph) OAG_NOEXCEPT;
        Context(Graph &graph) OAG_NOEXCEPT;
        ~Context() OAG_NOEXCEPT;
        
        const bool thread_is_updating() const OAG_NOEXCEPT;
        
        OAG_INLINE OAG_CONSTEXPR
        const bool has_graph() const OAG_NOEXCEPT {
            return _graph != nullptr;
        }
        
        OAG_INLINE OAG_CONSTEXPR
        const Graph &get_graph() const OAG_NOEXCEPT {
            return *_graph;
        }
        
        OAG_INLINE OAG_CONSTEXPR
        Graph &get_graph() OAG_NOEXCEPT {
            return *_graph;
        }
        
        OAG_INLINE OAG_CONSTEXPR
        const void * _Nullable get_context() const OAG_NOEXCEPT {
            return _context;
        }
        
        OAG_INLINE OAG_CONSTEXPR
        void set_context(const void * _Nullable context) OAG_NOEXCEPT {
            _context = context;
        }
        
        OAG_INLINE
        void set_invalidation_callback(ClosureFunction<void, OAGAttribute> invalidation_callback) OAG_NOEXCEPT {
            _invalidation_callback = invalidation_callback;
        }
        
        OAG_INLINE
        void set_update_callback(ClosureFunction<void> update_callback) OAG_NOEXCEPT {
            _update_callback = update_callback;
        }
        
        OAG_INLINE OAG_CONSTEXPR
        const bool isInvalid() const OAG_NOEXCEPT {
            return _isInvalid;
        }
        
        OAG_INLINE OAG_CONSTEXPR
        void setInvalid(bool invalid) OAG_NOEXCEPT {
            _isInvalid = invalid;
        }
    };
    #if OAG_TARGET_CPU_WASM32
    static_assert(sizeof(Context) == 0x38);
    #else
    static_assert(sizeof(Context) == 0x50);
    #endif
private:
    static pthread_key_t _current_update_key;
    uint64_t _counter_4;
    uint32_t _counter_8;
    uint64_t _counter_0;
    bool _counter_9;
    uint64_t _counter_5;
    uint64_t _counter_1;
    uint64_t _counter_2;
    uint64_t _counter_10;
    uint64_t _counter_3;
public:
    #if OAG_OBJC_FOUNDATION
    static CFTypeRef description(const Graph * _Nullable graph, NSDictionary* dic);
    #endif /* OAG_OBJC_FOUNDATION */
    
    // MARK: - pthread related
    
    OAG_INLINE OAG_CONSTEXPR
    const static pthread_key_t& current_key() OAG_NOEXCEPT {
        return _current_update_key;
    }
    
    Graph() OAG_NOEXCEPT;
    
    const void value_mark_all() const OAG_NOEXCEPT;
    
    static void trace_assertion_failure(bool, const char *, ...) OAG_NOEXCEPT;

    static void all_start_profiling(uint32_t) OAG_NOEXCEPT;
    static void all_stop_profiling() OAG_NOEXCEPT;
    void start_profiling(uint32_t) OAG_NOEXCEPT;
    void stop_profiling() OAG_NOEXCEPT;

    #if OAG_OBJC_FOUNDATION
    static void write_to_file(const Graph * _Nullable, const char * _Nullable, uint8_t) OAG_NOEXCEPT;
    #endif

    const bool thread_is_updating() const OAG_NOEXCEPT;
    const bool is_context_updating(const OAG::Graph::Context&) const OAG_NOEXCEPT;
    
    OAG_INLINE OAG_CONSTEXPR
    const uint64_t get_counter_4() const OAG_NOEXCEPT {
        return _counter_4;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const uint32_t get_counter_8() const OAG_NOEXCEPT {
        return _counter_8;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const uint64_t get_counter_0() const OAG_NOEXCEPT {
        return _counter_0;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const bool get_counter_9() const OAG_NOEXCEPT {
        return _counter_9;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const uint64_t get_counter_5() const OAG_NOEXCEPT {
        return _counter_5;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const uint64_t get_counter_1() const OAG_NOEXCEPT {
        return _counter_1;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const uint64_t get_counter_2() const OAG_NOEXCEPT {
        return _counter_2;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const uint64_t get_counter_10() const OAG_NOEXCEPT {
        return _counter_10;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const uint64_t get_counter_3() const OAG_NOEXCEPT {
        return _counter_3;
    }
}; /* Graph */
} /* OAG */

struct OAGGraphStorage {
    CFRuntimeBase base;
    OAG::Graph::Context context;
};

struct OAGGraphContextStorage {
    OAG::Graph::Context context;
};

OAG_ASSUME_NONNULL_END

#endif /* Graph_hpp */

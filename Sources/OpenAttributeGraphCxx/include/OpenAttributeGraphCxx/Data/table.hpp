//
//  table.hpp
//  OpenAttributeGraphCxx

#ifndef table_hpp
#define table_hpp

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraphCxx/Vector/vector.hpp>

#if OAG_TARGET_OS_DARWIN
#include <mach/vm_types.h>
#else
typedef uintptr_t               vm_size_t;
typedef uintptr_t               vm_offset_t;
typedef vm_offset_t             vm_address_t;
#endif
#include <bitset>
#if OAG_TARGET_OS_DARWIN
#include <os/lock.h>
#endif

OAG_ASSUME_NONNULL_BEGIN

namespace OAG {
namespace data {
class zone;
class page;
template <typename T> class ptr;

class table {
public:
    class malloc_zone_deleter {
        void operator()(void* ptr) const {
            #if OAG_TARGET_OS_DARWIN
            malloc_zone_free(_malloc_zone, ptr);
            #endif
        }
    };

    #if OAG_TARGET_OS_DARWIN
    static malloc_zone_t *_malloc_zone;
    #endif

public:
    static table &ensure_shared();

    OAG_INLINE OAG_CONSTEXPR
    vm_address_t data_base() const OAG_NOEXCEPT { return _data_base; };

    OAG_INLINE OAG_CONSTEXPR
    vm_address_t region_base() const OAG_NOEXCEPT { return _region_base; };

    OAG_INLINE OAG_CONSTEXPR
    void lock() const OAG_NOEXCEPT {
        #if OAG_TARGET_OS_DARWIN
        return os_unfair_lock_lock(&_lock);
        #endif
    };

    OAG_INLINE OAG_CONSTEXPR
    void unlock() const OAG_NOEXCEPT {
        #if OAG_TARGET_OS_DARWIN
        return os_unfair_lock_unlock(&_lock);
        #endif
    };

    OAG_INLINE OAG_CONSTEXPR
    uint32_t region_capacity() const OAG_NOEXCEPT { return _region_capacity; };

    OAG_INLINE OAG_CONSTEXPR
    uint32_t data_capacity() const OAG_NOEXCEPT { return _data_capacity; };

    OAG_INLINE OAG_CONSTEXPR
    uint32_t used_pages_num() const OAG_NOEXCEPT { return _used_pages_num; };

    OAG_INLINE OAG_CONSTEXPR
    uint32_t reusable_pages_num() const OAG_NOEXCEPT { return _reusable_pages_num; };

    OAG_INLINE OAG_CONSTEXPR
    uint32_t map_search_start() const OAG_NOEXCEPT { return _map_search_start; };

    OAG_INLINE OAG_CONSTEXPR
    uint32_t zones_num() const OAG_NOEXCEPT { return _zones_num; };

    OAG_INLINE OAG_CONSTEXPR
    uint32_t make_zone_id() {
        _zones_num += 1;
        return _zones_num;
    }

    template <typename T>
    OAG_INLINE
    void assert_valid(const ptr<T>& p) const {
        if (data_capacity() <= p._offset) {
            precondition_failure("invalid data offset: %u", p._offset);
        }
    }

    table();

    void grow_region() OAG_NOEXCEPT;

    void make_pages_reusable(uint32_t page_index, bool reusable) OAG_NOEXCEPT;

    ptr<page> alloc_page(zone *zone, uint32_t size) OAG_NOEXCEPT;

    void dealloc_page_locked(ptr<page> page) OAG_NOEXCEPT;

    OAG_INLINE OAG_CONSTEXPR
    uint64_t raw_page_seed(ptr<page> page) const OAG_NOEXCEPT;

    void print() const OAG_NOEXCEPT;
private:
    /// _region_base - page_size
    vm_address_t _data_base;

    vm_address_t _region_base;

    #if OAG_TARGET_OS_DARWIN
    mutable os_unfair_lock _lock = OS_UNFAIR_LOCK_INIT;
    #endif

    uint32_t _region_capacity;

    /// _region_capactiy + page_size
    uint32_t _data_capacity;

    uint32_t _used_pages_num = 0;

    uint32_t _reusable_pages_num = 0;

    uint32_t _map_search_start = 0;

    uint32_t _zones_num = 0;

    using remapped_region = std::pair<vm_address_t, int64_t>;
    vector<remapped_region, 0, uint32_t> _remapped_regions = {};

    OAG_CONSTEXPR static unsigned int pages_per_map = 64;

    using page_map_type = std::bitset<pages_per_map>;
    vector<page_map_type, 0, uint32_t> _page_maps = {};
    vector<page_map_type, 0, uint32_t> _page_metadata_maps = {};
}; /* table */

static uint8_t _shared_table_bytes[sizeof(table) / sizeof(uint8_t)] = {};

OAG_INLINE
static table &shared_table() {
    return *reinterpret_cast<data::table *>(&_shared_table_bytes);
}

} /* data */
} /* OAG */

OAG_ASSUME_NONNULL_END

#endif /* table_hpp */

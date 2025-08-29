//
//  zone.hpp
//  OpenAttributeGraphCxx

#ifndef zone_hpp
#define zone_hpp

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraphCxx/Data/ptr.hpp>

namespace OAG {
namespace data {

class zone {
public:
    class info {
    public:
        OAG_INLINE OAG_CONSTEXPR
        info() OAG_NOEXCEPT : _value(0) {};

        OAG_INLINE OAG_CONSTEXPR
        info(uint32_t value) OAG_NOEXCEPT : _value(value){};

        OAG_INLINE OAG_CONSTEXPR
        info(uint32_t zone_id, bool deleted) OAG_NOEXCEPT : _value((zone_id & zone_id_mask) | (deleted ? 1 : 0)) {};

        OAG_INLINE OAG_CONSTEXPR
        uint32_t value() const OAG_NOEXCEPT { return _value; };

        OAG_INLINE OAG_CONSTEXPR
        uint32_t zone_id() const OAG_NOEXCEPT { return _value & zone_id_mask; };

        OAG_INLINE OAG_CONSTEXPR
        bool is_deleted() const OAG_NOEXCEPT { return (_value & deleted) != 0; };

        OAG_INLINE OAG_CONSTEXPR
        info with_zone_id(uint32_t zone_id) const OAG_NOEXCEPT {
            return info((_value & ~zone_id_mask) | (zone_id & zone_id_mask), is_deleted());
        };

        OAG_INLINE OAG_CONSTEXPR
        info with_deleted(bool deleted) const OAG_NOEXCEPT {
            return info(zone_id(), deleted);
        }
    private:
        enum : uint32_t {
            zone_id_mask = 0x7fffffff,
            deleted = 0x80000000,
        };
        uint32_t _value;
    }; /* info */
public:
//    zone() OAG_NOEXCEPT = default;
//    ~zone() OAG_NOEXCEPT;

    OAG_INLINE OAG_CONSTEXPR
    auto& malloc_buffers() const OAG_NOEXCEPT { return _malloc_buffers; };

    OAG_INLINE OAG_CONSTEXPR
    ptr<page> last_page() const OAG_NOEXCEPT { return _last_page; };

    OAG_INLINE OAG_CONSTEXPR
    info info() const OAG_NOEXCEPT { return _info; };

    OAG_INLINE
    void clear();

    ptr<void> alloc_slow(uint32_t size, uint32_t alignment_mask) OAG_NOEXCEPT;

    void *alloc_persistent(size_t size) OAG_NOEXCEPT;

    void realloc_bytes(ptr<void> *buffer, uint32_t size, uint32_t new_size, uint32_t alignment_mask) OAG_NOEXCEPT;

//    ptr<void> alloc_bytes(uint32_t size, uint32_t alignment_mask);
    ptr<void> alloc_bytes_recycle(uint32_t size, uint32_t alignment_mask) OAG_NOEXCEPT;

    // Printing
    void print() const OAG_NOEXCEPT;

    void print_header() const OAG_NOEXCEPT;
private:
    typedef struct _bytes_info {
        ptr<struct _bytes_info> next;
        uint32_t size;
    } bytes_info;
    vector<std::unique_ptr<void, table::malloc_zone_deleter>, 0, uint32_t> _malloc_buffers;
    ptr<page> _last_page;
    ptr<bytes_info> _free_bytes;
    class info _info;
}; /* zone */

} /* data */
} /* OAG */

#endif /* zone_hpp */

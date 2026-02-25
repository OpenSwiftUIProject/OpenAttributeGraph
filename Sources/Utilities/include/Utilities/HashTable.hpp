//
//  HashTable.hpp
//  Utilities
//
//  Audited for 6.5.4
//  Status: Complete

#ifndef UTILITIES_HASHTABLE_HPP
#define UTILITIES_HASHTABLE_HPP

#include <Utilities/Base.hpp>

OAG_ASSUME_NONNULL_BEGIN

namespace util {

class Heap;

uint64_t string_hash(char const *str);

class UntypedTable {
public:
    using key_type = const void *_Nonnull;
    using nullable_key_type = const void *_Nullable;
    using value_type = const void *_Nullable;
    using size_type = uint64_t;
    using hasher = uint64_t (*)(void const *);
    using key_equal = bool (*)(void const *, void const *);
    using key_callback = void (*)(const key_type);
    using value_callback = void (*)(const value_type);
    using entry_callback = void (*)(const key_type, const value_type, void *context);

private:
    struct HashNode {
        HashNode *next;
        key_type key;
        value_type value;
        uint64_t hash_value;
    };
    using Bucket = HashNode *_Nonnull;

    hasher _hash;
    key_equal _compare;
    key_callback _did_remove_key;
    value_callback _did_remove_value;
    Heap *_heap;
    HashNode *_spare_node;
    Bucket *_Nonnull _buckets;
    uint64_t _count;
    uint64_t _bucket_mask;
    uint32_t _bucket_mask_width;
    bool _is_heap_owner;
    bool _compare_by_pointer;

    #if DEBUG
    // Layout verification
    static constexpr void _verify_layout() {
        static_assert(offsetof(HashNode, next) == 0x00);
        static_assert(offsetof(HashNode, key) == 0x08);
        static_assert(offsetof(HashNode, value) == 0x10);
        static_assert(offsetof(HashNode, hash_value) == 0x18);
        static_assert(sizeof(HashNode) == 0x20);
        static_assert(offsetof(UntypedTable, _hash) == 0x00);
        static_assert(offsetof(UntypedTable, _compare) == 0x08);
        static_assert(offsetof(UntypedTable, _did_remove_key) == 0x10);
        static_assert(offsetof(UntypedTable, _did_remove_value) == 0x18);
        static_assert(offsetof(UntypedTable, _heap) == 0x20);
        static_assert(offsetof(UntypedTable, _spare_node) == 0x28);
        static_assert(offsetof(UntypedTable, _buckets) == 0x30);
        static_assert(offsetof(UntypedTable, _count) == 0x38);
        static_assert(offsetof(UntypedTable, _bucket_mask) == 0x40);
        static_assert(offsetof(UntypedTable, _bucket_mask_width) == 0x48);
        static_assert(offsetof(UntypedTable, _is_heap_owner) == 0x4c);
        static_assert(offsetof(UntypedTable, _compare_by_pointer) == 0x4d);
        static_assert(sizeof(UntypedTable) == 0x50);
    }
    #endif

    // Managing buckets
    void create_buckets();
    void grow_buckets();

public:
    static UntypedTable *create();
    static void destroy(UntypedTable *value);

    UntypedTable();
    UntypedTable(hasher _Nullable custom_hasher, key_equal _Nullable custom_compare,
                 key_callback _Nullable did_remove_key, value_callback _Nullable did_remove_value,
                 Heap *_Nullable heap);
    ~UntypedTable();

    // non-copyable
    UntypedTable(const UntypedTable &) = delete;
    UntypedTable &operator=(const UntypedTable &) = delete;

    // non-movable
    UntypedTable(UntypedTable &&) = delete;
    UntypedTable &operator=(UntypedTable &&) = delete;

    // Lookup
    bool empty() const noexcept { return _count == 0; };
    size_type count() const noexcept { return _count; };
    value_type lookup(key_type key, nullable_key_type *_Nullable found_key) const noexcept;
    void for_each(entry_callback body, void *context) const;

    // Modifiers
    bool insert(const key_type key, const value_type value);
    bool remove(const key_type key);
    bool remove_ptr(const key_type key);
} SWIFT_UNSAFE_REFERENCE;

template <typename Key, typename Value> class Table : public UntypedTable {
public:
    using key_type = Key;
    using value_type = Value;
    using hasher = uint64_t (*)(const key_type);
    using key_equal = bool (*)(const key_type, const key_type);
    using key_callback = void (*)(const key_type);
    using value_callback = void (*)(const value_type);
    using entry_callback = void (*)(const key_type, const value_type, void *context);

    Table() : UntypedTable() {};
    Table(hasher _Nullable custom_hasher, key_equal _Nullable custom_compare, key_callback _Nullable did_remove_key,
          value_callback _Nullable did_remove_value, Heap *_Nullable heap)
        : UntypedTable(reinterpret_cast<UntypedTable::hasher>(custom_hasher),
                       reinterpret_cast<UntypedTable::key_equal>(custom_compare),
                       reinterpret_cast<UntypedTable::key_callback>(did_remove_key),
                       reinterpret_cast<UntypedTable::value_callback>(did_remove_value), heap) {};

    // Lookup

    value_type lookup(const key_type key, key_type *_Nullable found_key) const noexcept {
        auto result = UntypedTable::lookup(*(void **)&key,
                                           reinterpret_cast<UntypedTable::nullable_key_type *_Nullable>(found_key));
        return *(value_type *)&result;
    };

    void for_each(entry_callback _Nonnull body, void *_Nullable context) const {
        UntypedTable::for_each((UntypedTable::entry_callback)body, context);
    };

    // Modifying entries

    bool insert(const key_type key, const value_type value) {
        return UntypedTable::insert(*(void **)&key, *(void **)&value);
    };
    bool remove(const key_type key) { return UntypedTable::remove(*(void **)&key); };
    bool remove_ptr(const key_type key) { return UntypedTable::remove_ptr(key); };
};

} /* namespace util */

OAG_ASSUME_NONNULL_END

#endif /* UTILITIES_HASHTABLE_HPP */

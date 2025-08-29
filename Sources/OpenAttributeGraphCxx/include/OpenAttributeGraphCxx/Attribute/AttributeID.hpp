//
//  AttributeID.hpp
//  OpenAttributeGraphCxx

#ifndef AttributeID_hpp
#define AttributeID_hpp

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGAttribute.h>
#include <OpenAttributeGraphCxx/Misc/assert.hpp>

namespace OAG {
class AttributeID final {
public:
    enum : uint32_t {
      KindMask =            0x00000003, // Bits 0-1
      // unused/unknown     0x0000FF00,
    };
    enum class Kind: uint8_t {
        Direct = 0x0,
        Indirect = 0x1,
        Null = 0x2,
    };
private:
    uint32_t _rawValue;
    
    OAG_INLINE OAG_CONSTEXPR
    const Kind getKind() const OAG_NOEXCEPT {
        return Kind(_rawValue & KindMask);
    }
public:
    OAG_INLINE OAG_CONSTEXPR
    AttributeID(OAGAttribute& attribute) OAG_NOEXCEPT:
    _rawValue(attribute) {}
    
    OAG_INLINE OAG_CONSTEXPR
    AttributeID(const AttributeID &) noexcept = default;
    
    OAG_INLINE OAG_CONSTEXPR
    AttributeID(AttributeID &&) noexcept = default;
    
    OAG_INLINE OAG_CONSTEXPR
    AttributeID &operator=(const AttributeID &) noexcept = default;
    
    OAG_INLINE OAG_CONSTEXPR
    AttributeID &operator=(AttributeID &&) noexcept = default;
    
    OAG_INLINE OAG_CONSTEXPR
    const bool isDirect() const OAG_NOEXCEPT {
        return getKind() == Kind::Direct;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const bool isIndirect() const OAG_NOEXCEPT {
        return getKind() == Kind::Indirect;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const bool isNull() const OAG_NOEXCEPT {
        return getKind() == Kind::Null;
    }
    
    OAG_INLINE OAG_CONSTEXPR
    const void checkIsDirect() const OAG_NOEXCEPT {
        if (!isDirect()) {
            OAG::precondition_failure("non-direct attribute id: %u", _rawValue);
        }
    }
};
static_assert(sizeof(AttributeID) == sizeof(uint32_t));
}

#endif /* AttributeID_hpp */

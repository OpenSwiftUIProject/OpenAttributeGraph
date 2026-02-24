//
//  metadata.hpp
//  OpenAttributeGraphCxx
//
//  Audited for iOS 18.0
//  Status: WIP

#ifndef metadata_hpp
#define metadata_hpp

#include <OpenAttributeGraph/OAGBase.h>

#include <swift/Runtime/Metadata.h>
#include <swift/Runtime/HeapObject.h>
using namespace swift;

namespace OAG {
namespace swift {
class metadata: public Metadata {
public:
    OAG_INLINE OAG_CONSTEXPR
    Metadata const* getType() const OAG_NOEXCEPT {
        return this;
    }

    OAG_INLINE OAG_CONSTEXPR
    TypeNamePair const name(bool qualified) const OAG_NOEXCEPT {
        return swift_getTypeName(getType(), qualified);
    }

    OAG_INLINE OAG_CONSTEXPR
    MetadataKind const getKind() const OAG_NOEXCEPT {
        return getType()->getKind();
    }

    OAG_INLINE OAG_CONSTEXPR
    TypeContextDescriptor const* descriptor() const OAG_NOEXCEPT {
        switch (getKind()) {
            case MetadataKind::Class: {
                const auto cls = static_cast<const ClassMetadata *>(getType());
                #if SWIFT_OBJC_INTEROP
                // We may build this with a newer OS SDK but run on old OS.
                // So instead of using `isTypeMetadata` / `(Data & SWIFT_CLASS_IS_SWIFT_MASK)`,
                // we manully use 3 here to check isTypeMetadata
                if ((cls->Data & 3) == 0) return nullptr;
                #endif
                return cls->getDescription();
            }
            case MetadataKind::Struct:
            case MetadataKind::Enum:
            case MetadataKind::Optional: {
                return static_cast<const TargetValueMetadata<InProcess> *>(getType())->Description;
            }
            default:
                return nullptr;
        }
    }

    OAG_INLINE OAG_CONSTEXPR
    TypeContextDescriptor const* nominal_descriptor() const OAG_NOEXCEPT {
        auto descriptor = this->descriptor();
        if (descriptor == nullptr) {
            return nullptr;
        }
        switch(descriptor->getKind()) {
            case ContextDescriptorKind::Struct:
            case ContextDescriptorKind::Enum:
                return descriptor;
            default:
                return nullptr;
        }
    }

    void append_description(CFMutableStringRef description) const OAG_NOEXCEPT;
}; /* OAG::swift::metadata */
} /* OAG::swift */
} /* OAG */

#endif /* metadata_hpp */

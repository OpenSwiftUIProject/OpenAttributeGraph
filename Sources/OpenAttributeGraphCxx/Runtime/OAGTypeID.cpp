//
//  OAGTypeID.cpp
//  OpenAttributeGraphCxx
//
//  Audited for iOS 18.0
//  Status: WIP

#include <OpenAttributeGraph/OAGTypeID.h>
#include <OpenAttributeGraphCxx/Runtime/metadata.hpp>
#include <OpenAttributeGraphCxx/Misc/assert.hpp>

#include <swift/Runtime/Metadata.h>

OAGTypeKind OAGTypeGetKind(OAGTypeID typeID) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(typeID);
    switch (metadata->getKind()) {
        case swift::MetadataKind::Class: // 0x0
            return OAGTypeKindClass;
        case swift::MetadataKind::Struct: // 0x200
            return OAGTypeKindStruct;
        case swift::MetadataKind::Enum: // 0x201
            return OAGTypeKindEnum;
        case swift::MetadataKind::Optional: // 0x202
            return OAGTypeKindOptional;
        case swift::MetadataKind::Tuple: // 0x301
            return OAGTypeKindTuple;
        case swift::MetadataKind::Function: // 0x302
            return OAGTypeKindFunction;
        case swift::MetadataKind::Existential: // 0x303
            return OAGTypeKindExistential;
        case swift::MetadataKind::Metatype: // 0x304
            return OAGTypeKindMetatype;
        default:
            return OAGTypeKindNone;
    }
}

void OAGTypeApplyFields(const void *type, const void *block, void *context) {
    // TODO
    return;
}

bool OAGTypeApplyFields2(const void *type, OAGTypeApplyOptions options, const void *block, void *context) {
    // TODO
    return false;
}

#if OPENATTRIBUTEGRAPH_RELEASE >= OPENATTRIBUTEGRAPH_RELEASE_2024

uint32_t OAGTypeGetEnumTag(OAGTypeID typeID, const void *value) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(typeID);
    auto vwt = metadata->getValueWitnesses();
    if (!swift::EnumValueWitnessTable::classof(vwt)) {
        OAG::precondition_failure("not an enum type: %s", metadata->name(false).data);
    }
    auto enum_vwt = static_cast<const swift::EnumValueWitnessTable *>(vwt);
    return enum_vwt->getEnumTag(static_cast<const swift::OpaqueValue *>(value), metadata);
}

void OAGTypeProjectEnumData(OAGTypeID typeID, void *value) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(typeID);
    auto vwt = metadata->getValueWitnesses();
    if (!swift::EnumValueWitnessTable::classof(vwt)) {
        OAG::precondition_failure("not an enum type: %s", metadata->name(false).data);
    }
    auto enum_vwt = static_cast<const swift::EnumValueWitnessTable *>(vwt);
    enum_vwt->destructiveProjectEnumData(static_cast<swift::OpaqueValue *>(value), metadata);
}

void OAGTypeInjectEnumTag(OAGTypeID typeID, uint32_t tag, void *value) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(typeID);
    auto vwt = metadata->getValueWitnesses();
    if (!swift::EnumValueWitnessTable::classof(vwt)) {
        OAG::precondition_failure("not an enum type: %s", metadata->name(false).data);
    }
    auto enum_vwt = static_cast<const swift::EnumValueWitnessTable *>(vwt);
    return enum_vwt->destructiveInjectEnumTag(static_cast<swift::OpaqueValue *>(value), tag, metadata);
}

#endif /* OPENATTRIBUTEGRAPH_RELEASE */

bool OAGTypeApplyEnumData() {
    // TODO
    return false;
}

bool OAGTypeApplyMutableEnumData() {
    // TODO
    return false;
}

CFStringRef OAGTypeDescription(OAGTypeID typeID) {
    CFMutableStringRef ref = CFStringCreateMutable(CFAllocatorGetDefault(), 0);
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(typeID);
    metadata->append_description(ref);
    return ref;
}

#if OPENATTRIBUTEGRAPH_RELEASE >= OPENATTRIBUTEGRAPH_RELEASE_2024

OAGTypeSignature const OAGTypeGetSignature(OAGTypeID typeID) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(typeID);
    // TODO
    return OAGTypeSignature{};
}
void const* OAGTypeGetDescriptor(OAGTypeID typeID) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(typeID);
    return metadata->descriptor();
}

#endif /* OPENATTRIBUTEGRAPH_RELEASE */

void const* OAGTypeNominalDescriptor(OAGTypeID typeID) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(typeID);
    return metadata->nominal_descriptor();
}

char const* OAGTypeNominalDescriptorName(OAGTypeID typeID) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(typeID);
    auto nominal_descriptor = metadata->nominal_descriptor();
    if (nominal_descriptor == nullptr) {
        return nullptr;
    }
    return nominal_descriptor->Name.get();
}

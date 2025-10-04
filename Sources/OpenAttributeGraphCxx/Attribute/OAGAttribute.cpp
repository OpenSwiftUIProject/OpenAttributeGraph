//
//  OAGAttribute.cpp
//  OpenAttributeGraphCxx

#include <OpenAttributeGraph/OAGAttribute.h>
#include <OpenAttributeGraphCxx/Attribute/AttributeID.hpp>
#include <OpenAttributeGraphCxx/Misc/assert.hpp>
#include <optional>

const OAGAttribute OAGAttributeNil = OAGAttribute(OAG::AttributeID::Kind::Null);

OAGAttribute OAGGraphGetCurrentAttribute(void) {
    // TODO
    return OAGAttributeNil;
}

bool OAGGraphCurrentAttributeWasModified(void) {
    // TODO
    return false;
}

namespace {
OAGAttribute create_offset_attribute(OAGAttribute attribute, uint64_t offset, std::optional<uint64_t> size) {
    // TODO
    return OAGAttributeNil;
}
}

OAGAttribute OAGGraphCreateOffsetAttribute(OAGAttribute attribute, long offset) {
    return create_offset_attribute(attribute, offset, std::nullopt);
}

OAGAttribute OAGGraphCreateOffsetAttribute2(OAGAttribute attribute, long offset, uint64_t size) {
    return create_offset_attribute(attribute, offset, std::optional(size));
}

namespace {
OAGAttribute create_indirect_attribute(OAGAttribute attribute, std::optional<uint64_t> size) {
    // TODO
    return OAGAttributeNil;
}
}

OAGAttribute OAGGraphCreateIndirectAttribute(OAGAttribute attribute) {
    return create_indirect_attribute(attribute, std::nullopt);
}

OAGAttribute OAGGraphCreateIndirectAttribute2(OAGAttribute attribute, uint64_t size) {
    return create_indirect_attribute(attribute, std::optional(size));
}

OAGAttributeFlags OAGGraphGetFlags(OAGAttribute attribute) {
    const OAG::AttributeID id = OAG::AttributeID(attribute);
    id.checkIsDirect();
    // TODO: data/table
    return OAGAttributeFlagsNone;
}

void OAGGraphSetFlags(OAGAttribute attribute, OAGAttributeFlags flags) {
    const OAG::AttributeID id = OAG::AttributeID(attribute);
    id.checkIsDirect();
    // TODO: data/table
}

void OAGGraphAddInput(OAGAttribute attribute1, OAGAttribute attribute2, OAGInputOptions options, long token) {
    const OAG::AttributeID id = OAG::AttributeID(attribute1);
    id.checkIsDirect();
    // TODO: data/table
}

const OAGAttributeInfo OAGGraphGetAttributeInfo(OAGAttribute attribute) {
    const OAG::AttributeID id = OAG::AttributeID(attribute);
    id.checkIsDirect();
    // TODO
    return { nullptr, nullptr };
}

void OAGGraphMutateAttribute(OAGAttribute attribute,
                            const OAGTypeID type,
                            bool invalidating,
                            const void (*function)(const void * _Nullable context OAG_SWIFT_CONTEXT, void *body) OAG_SWIFT_CC(swift),
                            const void * _Nullable context) {
    const OAG::AttributeID id = OAG::AttributeID(attribute);
    id.checkIsDirect();
    // attribute_modify(AG::data::ptr<AG::Node>, AGSwiftMetadata const*, AG::ClosureFunction<void, void*>, bool
}

OAGAttribute OAGGraphGetIndirectDependency(OAGAttribute attribute) {
    // TODO
    return OAGAttributeNil;
}

void OAGGraphSetIndirectDependency(OAGAttribute attribute1, OAGAttribute attribute2) {
    // TODO
}

OAGAttribute OAGGraphGetIndirectAttribute(OAGAttribute attribute) {
    // TODO
    return OAGAttributeNil;
}

void OAGGraphSetIndirectAttribute(OAGAttribute attribute1, OAGAttribute attribute2) {
    // TODO
}

void OAGGraphResetIndirectAttribute(OAGAttribute attribute, bool non_nil) {
    // TODO
}

OAGAttribute OAGGraphCreateAttribute(long index, const void *body, const void * value) {
    // TODO
    return OAGAttributeNil;
}

const OAGValue OAGGraphGetValue(OAGAttribute attribute, OAGValueOptions options, OAGTypeID type) {
    // TODO
    return OAGValue { nullptr, false };
}

bool OAGGraphSetValue(OAGAttribute attribute, const void *value, OAGTypeID type) {
    // TODO
    return false;
}

const OAGValue OAGGraphGetInputValue(OAGAttribute attribute, OAGAttribute inputAttribute, OAGValueOptions options, const OAGTypeID type) {
    // TODO
    return OAGValue { nullptr, false };
}

const void * _Nullable OAGGraphGetOutputValue(OAGTypeID type) {
    // TODO
    return nullptr;
}

void OAGGraphSetOutputValue(const void *value, const OAGTypeID type) {
    // TODO
}

OAGValueState OAGGraphGetValueState(OAGAttribute attribute) {
    // TODO
    return {};
}

bool OAGGraphHasValue(OAGAttribute attribute) {
    // TODO
    return false;
}

void OAGGraphUpdateValue(OAGAttribute attribute) {
    // TODO
}

void OAGGraphPrefetchValue(OAGAttribute attribute) {
    // TODO
}

void OAGGraphInvalidateValue(OAGAttribute attribute) {
    // TODO
}

void OAGGraphVerifyType(OAGAttribute attribute, OAGTypeID type) {
    // TODO
}

OAGGraphRef OAGGraphGetAttributeGraph(OAGAttribute attribute) {
    // TODO
    return nullptr;
}

OAGSubgraphRef OAGGraphGetAttributeSubgraph(OAGAttribute attribute) {
    OAGSubgraphRef subgraph = OAGGraphGetAttributeSubgraph2(attribute);
    if (subgraph == nullptr) {
        OAG::precondition_failure("no subgraph");
    }
    return subgraph;
}

_Nullable OAGSubgraphRef OAGGraphGetAttributeSubgraph2(OAGAttribute attribute) {
    auto attribute_id = OAG::AttributeID(attribute);
//    attribute_id.validate_data_offset();
//    auto subgraph = attribute_id.subgraph();
//    if (subgraph == nullptr) {
//        OAG::precondition_failure("internal error");
//    }
//    return subgraph->to_cf();
    // TODO
    return nullptr;
}

const void * OAGGraphReadCachedAttribute(long hashValue, OAGTypeID bodyType, const void *bodyPointer, OAGTypeID valueType, OAGCachedValueOptions options, OAGAttribute attribute, bool unknown) {
    // TODO
    return nullptr;
}

const void * _Nullable OAGGraphReadCachedAttributeIfExists(long hashValue, OAGTypeID bodyType, const void *bodyPointer, OAGTypeID valueType, OAGCachedValueOptions options, OAGAttribute attribute, bool unknown) {
    // TODO
    return nullptr;
}

void OAGGraphWithUpdate(
    OAGAttribute attribute,
    void (* callback)(const void *context OAG_SWIFT_CONTEXT) OAG_SWIFT_CC(swift),
    const void *context
) {
    // TODO
    callback(context);
}

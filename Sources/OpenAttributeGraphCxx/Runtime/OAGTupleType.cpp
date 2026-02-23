//
//  OAGTupleType.cpp
//  OpenAttributeGraphCxx
//
//  Audited for iOS 18.0
//  Status: Complete

#include <OpenAttributeGraph/OAGTupleType.h>
#include <OpenAttributeGraphCxx/Runtime/metadata.hpp>
#include <OpenAttributeGraphCxx/Misc/assert.hpp>

#include <swift/Runtime/Metadata.h>

OAGTupleType OAGNewTupleType(size_t count, const OAGTypeID *elements) {
    if (count == 1) {
        return elements[0];
    }
    auto metadata_elements = reinterpret_cast<const Metadata* const*>(elements);
    const auto response = swift_getTupleTypeMetadata(MetadataState::Complete, count, metadata_elements, nullptr, nullptr);
    if (response.State != MetadataState::Complete) {
        OAG::precondition_failure("invalid tuple type.");
    }
    return reinterpret_cast<OAGTupleType>(response.Value);
}

size_t OAGTupleCount(OAGTupleType tuple_type) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(tuple_type);
    if (metadata->getKind() != swift::MetadataKind::Tuple) {
        return 1;
    }
    auto tuple_metadata = reinterpret_cast<const swift::TupleTypeMetadata *>(metadata);
    return tuple_metadata->NumElements;
}

size_t OAGTupleSize(OAGTupleType tuple_type) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(tuple_type);
    return metadata->vw_size();
}

OAGTypeID OAGTupleElementType(OAGTupleType tuple_type, size_t index) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(tuple_type);
    if (metadata->getKind() != swift::MetadataKind::Tuple) {
        if (index != 0) {
            OAG::precondition_failure("index out of range: %d", index);
        }
        return reinterpret_cast<OAGTypeID>(metadata);
    }
    auto tuple_metadata = reinterpret_cast<const swift::TupleTypeMetadata *>(metadata);
    if (tuple_metadata->NumElements <= index) {
        OAG::precondition_failure("index out of range: %d", index);
    }
    auto element = tuple_metadata->getElement(unsigned(index));
    return reinterpret_cast<OAGTypeID>(element.Type);
}

size_t OAGTupleElementSize(OAGTupleType tuple_type, size_t index) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(tuple_type);
    if (metadata->getKind() != swift::MetadataKind::Tuple) {
        if (index != 0) {
            OAG::precondition_failure("index out of range: %d", index);
        }
        return metadata->vw_size();
    }
    auto tuple_metadata = reinterpret_cast<const swift::TupleTypeMetadata *>(metadata);
    if (tuple_metadata->NumElements <= index) {
        OAG::precondition_failure("index out of range: %d", index);
    }
    auto element = tuple_metadata->getElement(unsigned(index));
    return element.Type->vw_size();
}

size_t OAGTupleElementOffset(OAGTupleType tuple_type, size_t index) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(tuple_type);
    if (metadata->getKind() != swift::MetadataKind::Tuple) {
        if (index != 0) {
            OAG::precondition_failure("index out of range: %d", index);
        }
        return 0;
    }
    auto tuple_metadata = reinterpret_cast<const swift::TupleTypeMetadata *>(metadata);
    if (tuple_metadata->NumElements <= index) {
        OAG::precondition_failure("index out of range: %d", index);
    }
    auto element = tuple_metadata->getElement(unsigned(index));
    return element.Offset;
}

size_t OAGTupleElementOffsetChecked(OAGTupleType tuple_type, size_t index, OAGTypeID check_type) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(tuple_type);
    if (metadata->getKind() != swift::MetadataKind::Tuple) {
        if (index != 0) {
            OAG::precondition_failure("index out of range: %d", index);
        }
        if (reinterpret_cast<OAGTypeID>(metadata) != check_type) {
            OAG::precondition_failure("element type mismatch");
        }
        return 0;
    }
    auto tuple_metadata = reinterpret_cast<const swift::TupleTypeMetadata *>(metadata);
    if (tuple_metadata->NumElements <= index) {
        OAG::precondition_failure("index out of range: %d", index);
    }
    auto element = tuple_metadata->getElement(unsigned(index));
    if (reinterpret_cast<OAGTypeID>(element.Type) != check_type) {
        OAG::precondition_failure("element type mismatch");
    }
    return element.Offset;
}

void *update(void* dst_ptr, const void *src_ptr, const OAG::swift::metadata * metadata, OAGTupleCopyOptions options) {
    auto dst = reinterpret_cast<swift::OpaqueValue *>(dst_ptr);
    auto src = reinterpret_cast<swift::OpaqueValue *>(const_cast<void *>(src_ptr));
    switch (options) {
        case OAGTupleCopyOptionsAssignCopy:
            return metadata->vw_assignWithCopy(dst, src);
        case OAGTupleCopyOptionsInitCopy:
            return metadata->vw_initializeWithCopy(dst, src);
        case OAGTupleCopyOptionsAssignTake:
            return metadata->vw_assignWithTake(dst, src);
        case OAGTupleCopyOptionsInitTake:
            return metadata->vw_initializeWithTake(dst, src);
        default:
            OAG::precondition_failure("unknown copy options: %d", options);
    }
}

void *OAGTupleSetElement(OAGTupleType tuple_type, void* tuple_value, size_t index, const void *element_value, OAGTypeID check_type, OAGTupleCopyOptions options) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(tuple_type);
    if (metadata->getKind() != swift::MetadataKind::Tuple) {
        if (index != 0) {
            OAG::precondition_failure("index out of range: %d", index);
        }
        if (reinterpret_cast<OAGTypeID>(metadata) != check_type) {
            OAG::precondition_failure("element type mismatch");
        }
        return update(tuple_value, element_value, metadata, options);
    }
    auto tuple_metadata = reinterpret_cast<const swift::TupleTypeMetadata *>(metadata);
    if (tuple_metadata->NumElements <= index) {
        OAG::precondition_failure("index out of range: %d", index);
    }
    auto element = tuple_metadata->getElement(unsigned(index));
    if (reinterpret_cast<OAGTypeID>(element.Type) != check_type) {
        OAG::precondition_failure("element type mismatch");
    }
    return update((void *)(element.findIn(reinterpret_cast<swift::OpaqueValue *>(tuple_value))), element_value, reinterpret_cast<const OAG::swift::metadata *>(element.Type), options);
}

void *OAGTupleGetElement(OAGTupleType tuple_type, void* tuple_value, size_t index, void *element_value, OAGTypeID check_type, OAGTupleCopyOptions options) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(tuple_type);
    if (metadata->getKind() != swift::MetadataKind::Tuple) {
        if (index != 0) {
            OAG::precondition_failure("index out of range: %d", index);
        }
        if (reinterpret_cast<OAGTypeID>(metadata) != check_type) {
            OAG::precondition_failure("element type mismatch");
        }
        return update(element_value, tuple_value, metadata, options);
    }
    auto tuple_metadata = reinterpret_cast<const swift::TupleTypeMetadata *>(metadata);
    if (tuple_metadata->NumElements <= index) {
        OAG::precondition_failure("index out of range: %d", index);
    }
    auto element = tuple_metadata->getElement(unsigned(index));
    if (reinterpret_cast<OAGTypeID>(element.Type) != check_type) {
        OAG::precondition_failure("element type mismatch");
    }
    return update(element_value, (const void *)(element.findIn(reinterpret_cast<swift::OpaqueValue *>(tuple_value))), reinterpret_cast<const OAG::swift::metadata *>(element.Type), options);
}

void OAGTupleDestroy(OAGTupleType tuple_type, void *value) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(tuple_type);
    metadata->vw_destroy(reinterpret_cast<swift::OpaqueValue *>(value));
}

void OAGTupleDestroyElement(OAGTupleType tuple_type, void *value, size_t index) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(tuple_type);
    if (metadata->getKind() != swift::MetadataKind::Tuple) {
        if (index != 0) {
            OAG::precondition_failure("index out of range: %d", index);
        }
        metadata->vw_destroy(reinterpret_cast<swift::OpaqueValue *>(value));
    }
    auto tuple_metadata = reinterpret_cast<const swift::TupleTypeMetadata *>(metadata);
    if (tuple_metadata->NumElements <= index) {
        OAG::precondition_failure("index out of range: %d", index);
    }
    auto element = tuple_metadata->getElement(unsigned(index));
    auto element_type = element.Type;
    element_type->vw_destroy(reinterpret_cast<swift::OpaqueValue *>((intptr_t)value + index));
}

void OAGTupleWithBuffer(OAGTupleType tuple_type, size_t count, const void (* function)(const OAGUnsafeMutableTuple mutableTuple, const void * context OAG_SWIFT_CONTEXT) OAG_SWIFT_CC(swift), const void *context) {
    auto metadata = reinterpret_cast<OAG::swift::metadata const*>(tuple_type);
    auto buffer_size = metadata->vw_stride() * count;
    OAGUnsafeMutableTuple tuple;
    tuple.type = tuple_type;
    if (buffer_size <= 0x1000) {
        char buffer[buffer_size];
        bzero(buffer, buffer_size);
        tuple.value = buffer;
        // NOTE: If you use buffer out of the scope, the stack may be malformed.
        // So we need to call function in this scope.
        function(tuple, context);
    } else {
        void *buffer = malloc_type_malloc(buffer_size, 0x100004077774924);
        if (buffer == nullptr) {
            OAG::precondition_failure("memory allocation failure");
        }
        tuple.value = buffer;
        function(tuple, context);
        free(buffer);
    }
}

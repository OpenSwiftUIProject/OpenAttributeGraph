//
//  OGWeakAttribute.h
//  OpenGraphCxx

#ifndef OGWeakAttribute_hpp
#define OGWeakAttribute_hpp

#include <OpenGraphC/OGBase.h>
#include <OpenGraphC/OGAttribute.h>

OG_ASSUME_NONNULL_BEGIN

typedef struct OGWeakAttribute {
    const OGAttribute raw_attribute;
    const uint32_t subgraph_id;
} OGWeakAttribute;

OG_EXTERN_C_BEGIN

OG_EXPORT
OG_REFINED_FOR_SWIFT
OGWeakAttribute OGCreateWeakAttribute(OGAttribute attribute);

OG_EXPORT
OG_REFINED_FOR_SWIFT
OGAttribute OGWeakAttributeGetAttribute(OGWeakAttribute weakAttribute);

OG_EXPORT
OG_REFINED_FOR_SWIFT
OGValue OGGraphGetWeakValue(OGWeakAttribute weakAttribute, OGValueOptions options, OGTypeID type);

OG_EXTERN_C_END

OG_ASSUME_NONNULL_END

#endif /* OGWeakAttribute_h */

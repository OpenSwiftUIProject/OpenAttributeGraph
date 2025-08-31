//
//  OAGWeakAttribute.h
//  OpenAttributeGraphCxx

#ifndef OAGWeakAttribute_hpp
#define OAGWeakAttribute_hpp

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGAttribute.h>
#include <OpenAttributeGraph/OAGWeakValue.h>

OAG_ASSUME_NONNULL_BEGIN

typedef OAG_SWIFT_STRUCT struct {
    struct {
        OAGAttribute identifier;
        uint32_t seed;
    } _details;
} OAGWeakAttribute OAG_SWIFT_NAME(AnyWeakAttribute);

OAG_EXTERN_C_BEGIN

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGWeakAttribute OAGCreateWeakAttribute(OAGAttribute attribute);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGWeakAttributeGetAttribute(OAGWeakAttribute weakAttribute);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGWeakValue OAGGraphGetWeakValue(OAGWeakAttribute weakAttribute, OAGValueOptions options, OAGTypeID type);

OAG_EXTERN_C_END

OAG_ASSUME_NONNULL_END

#endif /* OAGWeakAttribute_h */

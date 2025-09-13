//
//  OAGTreeValue.h
//  OpenAttributeGraphCxx

#ifndef OAGTreeValue_h
#define OAGTreeValue_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGAttribute.h>
#include <OpenAttributeGraph/OAGTypeID.h>

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

OAG_EXTERN_C_BEGIN

typedef struct _OAGTreeValue *OAGTreeValue OAG_SWIFT_STRUCT OAG_SWIFT_NAME(TreeValue);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTypeID OAGTreeValueGetType(OAGTreeValue tree_value) OAG_SWIFT_NAME(getter:OAGTreeValue.type(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGTreeValueGetValue(OAGTreeValue tree_value) OAG_SWIFT_NAME(getter:OAGTreeValue.value(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
const char *OAGTreeValueGetKey(OAGTreeValue tree_value) OAG_SWIFT_NAME(getter:OAGTreeValue.key(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
uint32_t OAGTreeValueGetFlags(OAGTreeValue tree_value) OAG_SWIFT_NAME(getter:OAGTreeValue.flags(self:));

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGTreeValue_h */

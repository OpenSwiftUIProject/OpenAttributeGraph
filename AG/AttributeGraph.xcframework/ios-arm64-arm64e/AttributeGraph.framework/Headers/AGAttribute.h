//
//  AGAttribute.h
//
//
//  Created by Kyle on 2023/8/30.
//


#ifndef AGAttribute_h
#define AGAttribute_h

#include "AGBase.h"
#include "AGAttributeFlags.h"

typedef uint32_t AGAttribute __attribute((swift_newtype(struct)));

AG_EXTERN_C_BEGIN

AG_EXPORT
const AGAttribute AGAttributeNil;

AG_EXTERN_C_BEGIN
AG_EXPORT
const AGAttribute AGAttributeNil;
AG_EXTERN_C_END

AG_EXPORT
AG_REFINED_FOR_SWIFT
AGAttribute AGGraphGetCurrentAttribute(void);

AG_EXPORT
AG_REFINED_FOR_SWIFT
AGAttribute AGGraphCreateOffsetAttribute(AGAttribute attribute, uint64_t offset) AG_SWIFT_NAME(AGAttribute.create(self:offset:));

AG_EXPORT
AG_REFINED_FOR_SWIFT
AGAttribute AGGraphCreateOffsetAttribute2(AGAttribute attribute, uint64_t offset, uint64_t size) AG_SWIFT_NAME(AGAttribute.create(self:offset:size:));

AG_EXPORT
AG_REFINED_FOR_SWIFT
AGAttributeFlags AGGraphGetFlags(AGAttribute attribute) AG_SWIFT_NAME(getter:AGAttribute.flags(self:));

AG_EXPORT
AG_REFINED_FOR_SWIFT
void AGGraphSetFlags(AGAttribute attribute, AGAttributeFlags flags) AG_SWIFT_NAME(setter:AGAttribute.flags(self:_:));

AG_EXTERN_C_END

#endif /* AGAttribute_h */

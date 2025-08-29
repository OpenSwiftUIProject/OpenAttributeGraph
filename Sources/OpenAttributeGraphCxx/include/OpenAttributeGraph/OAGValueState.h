//
//  OAGValueState.h
//  OpenAttributeGraphCxx

#ifndef OAGValueState_h
#define OAGValueState_h

#include <OpenAttributeGraph/OAGBase.h>

OAG_ASSUME_NONNULL_BEGIN

typedef OAG_OPTIONS(uint8_t, OAGValueState) {
    OAGValueStateNone = 0,
    OAGValueStateDirty = 1 << 0,
    OAGValueStatePending = 1 << 1,
    OAGValueStateUpdating = 1 << 2,
    OAGValueStateValueExists = 1 << 3,
    OAGValueStateMainThread = 1 << 4,
    OAGValueStateMainRef = 1 << 5,
    OAGValueStateRequiresMainThread = 1 << 6,
    OAGValueStateSelfModified = 1 << 7,
} OAG_SWIFT_NAME(ValueState);

OAG_ASSUME_NONNULL_END

#endif /* OAGValueState_h */

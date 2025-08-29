//
//  OAGGraphCounterQueryType.h
//  OpenAttributeGraphCxx

#ifndef OAGGraphCounterQueryType_h
#define OAGGraphCounterQueryType_h

#include <OpenAttributeGraph/OAGBase.h>

typedef OAG_ENUM(uint32_t, OAGGraphCounterQueryType) {
    OAGGraphCounterQueryTypeNodes,
    OAGGraphCounterQueryTypeTransactions,
    OAGGraphCounterQueryTypeUpdates,
    OAGGraphCounterQueryTypeChanges,
    OAGGraphCounterQueryTypeContextID,
    OAGGraphCounterQueryTypeGraphID,
    OAGGraphCounterQueryTypeContextThreadUpdating,
    OAGGraphCounterQueryTypeThreadUpdating,
    OAGGraphCounterQueryTypeContextNeedsUpdate,
    OAGGraphCounterQueryTypeNeedsUpdate,
    OAGGraphCounterQueryTypeMainThreadUpdates,
    OAGGraphCounterQueryTypeCreatedNodes,
    OAGGraphCounterQueryTypeSubgraphs,
    OAGGraphCounterQueryTypeCreatedSubgraphs,
} OAG_SWIFT_NAME(OAGGraphRef.CounterQueryType);

#endif /* OAGGraphCounterQueryType_h */

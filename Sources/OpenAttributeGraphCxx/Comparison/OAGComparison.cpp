//
//  OAGCompareValues.cpp
//  OpenAttributeGraphCxx

#include <OpenAttributeGraph/OAGComparison.h>
#include <OpenAttributeGraphCxx/Comparison/OAGComparisonPrivate.h>

const void *OAGComparisonStateGetDestination(OAGComparisonState state) {
    return ((const OAGComparisonStateStorage *)state)->destination;
}

const void *OAGComparisonStateGetSource(OAGComparisonState state) {
    return ((const OAGComparisonStateStorage *)state)->source;
}

OAGFieldRange OAGComparisonStateGetFieldRange(OAGComparisonState state) {
    return ((const OAGComparisonStateStorage *)state)->field_range;
}

OAGTypeID OAGComparisonStateGetFieldType(OAGComparisonState state) {
    return ((const OAGComparisonStateStorage *)state)->field_type;
}

bool OAGCompareValues(const void *lhs, const void *rhs, OAGTypeID type, OAGComparisonOptions options) {
    // TODO
    return false;
}

const unsigned char *_Nullable OAGPrefetchCompareValues(OAGTypeID type_id,
                                                       OAGComparisonOptions options,
                                                       uint32_t priority) {
    // TODO
    return nullptr;
}

void OAGOverrideComparisonForTypeDescriptor(void *descriptor, OAGComparisonMode mode) {
    // TODO
}

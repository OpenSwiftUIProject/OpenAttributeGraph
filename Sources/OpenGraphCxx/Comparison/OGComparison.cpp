//
//  OGCompareValues.cpp
//  OpenGraphCxx

#include <OpenGraph/OGComparison.h>
#include <OpenGraphCxx/Comparison/OGComparisonPrivate.h>

const void *OGComparisonStateGetDestination(OGComparisonState state) {
    return ((const OGComparisonStateStorage *)state)->destination;
}

const void *OGComparisonStateGetSource(OGComparisonState state) {
    return ((const OGComparisonStateStorage *)state)->source;
}

OGFieldRange OGComparisonStateGetFieldRange(OGComparisonState state) {
    return ((const OGComparisonStateStorage *)state)->field_range;
}

OGTypeID OGComparisonStateGetFieldType(OGComparisonState state) {
    return ((const OGComparisonStateStorage *)state)->field_type;
}

bool OGCompareValues(const void *lhs, const void *rhs, OGTypeID type, OGComparisonOptions options) {
    // TODO
    return false;
}

const unsigned char *_Nullable OGPrefetchCompareValues(OGTypeID type_id,
                                                       OGComparisonOptions options,
                                                       uint32_t priority) {
    // TODO
    return nullptr;
}

void OGOverrideComparisonForTypeDescriptor(void *descriptor, OGComparisonMode mode) {
    // TODO
}

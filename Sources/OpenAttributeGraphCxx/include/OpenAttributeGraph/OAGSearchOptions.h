//
//  OAGSearchOptions.h
//  OpenAttributeGraphCxx

#ifndef OAGSearchOptions_h
#define OAGSearchOptions_h

#include <OpenAttributeGraph/OAGBase.h>

typedef OAG_OPTIONS(uint32_t, OAGSearchOptions) {
    OAGSearchOptionsSearchInputs = 1 << 0,
    OAGSearchOptionsSearchOutputs = 1 << 1,
    OAGSearchOptionsTraverseGraphContexts = 1 << 2,
} OAG_SWIFT_NAME(SearchOptions);

#endif /* Header_h */

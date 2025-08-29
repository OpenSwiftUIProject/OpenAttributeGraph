//
//  OAGGraphContext.h
//  OpenAttributeGraphCxx

#ifndef OAGGraphContext_h
#define OAGGraphContext_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGGraph.h>

// MARK: - Exported C functions

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

OAG_EXTERN_C_BEGIN

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGGraphRef OAGGraphContextGetGraph(OAGGraphContextRef context) OAG_SWIFT_NAME(getter:OAGGraphContextRef.graph(self:));

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGGraphContext_h */

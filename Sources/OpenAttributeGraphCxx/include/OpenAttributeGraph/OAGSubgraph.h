//
//  OAGSubgraph.h
//  OpenAttributeGraphCxx

#ifndef OAGSubgraph_h
#define OAGSubgraph_h

#include <OpenAttributeGraph/OAGAttribute.h>
#include <OpenAttributeGraph/OAGAttributeFlags.h>
#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGGraph.h>
#include <OpenAttributeGraph/OAGUniqueID.h>
#include <OpenAttributeGraph/Private/CFRuntime.h>

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

// MARK: - Exported C functions

OAG_EXTERN_C_BEGIN

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
CFTypeID OAGSubgraphGetTypeID(void) OAG_SWIFT_NAME(getter:OAGSubgraphRef.typeID());

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGSubgraphRef OAGSubgraphCreate(OAGGraphRef cf_graph) OAG_SWIFT_NAME(OAGSubgraphRef.init(graph:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGSubgraphRef OAGSubgraphCreate2(OAGGraphRef cf_graph, OAGAttribute attribute) OAG_SWIFT_NAME(OAGSubgraphRef.init(graph:attribute:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
_Nullable OAGSubgraphRef OAGSubgraphGetCurrent(void) OAG_SWIFT_NAME(getter:OAGSubgraphRef.current());

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphSetCurrent(_Nullable OAGSubgraphRef cf_subgraph) OAG_SWIFT_NAME(setter:OAGSubgraphRef.current(_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
_Nullable OAGGraphContextRef OAGSubgraphGetCurrentGraphContext(void) OAG_SWIFT_NAME(getter:OAGSubgraphRef.currentGraphContext());

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphInvalidate(OAGSubgraphRef cf_subgraph) OAG_SWIFT_NAME(OAGSubgraphRef.invalidate(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGSubgraphIsValid(OAGSubgraphRef cf_subgraph) OAG_SWIFT_NAME(getter:OAGSubgraphRef.isValid(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGGraphRef OAGSubgraphGetGraph(OAGSubgraphRef cf_subgraph) OAG_SWIFT_NAME(getter:OAGSubgraphRef.graph(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphAddChild(OAGSubgraphRef parent, OAGSubgraphRef child) OAG_SWIFT_NAME(OAGSubgraphRef.addChild(self:_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphAddChild2(OAGSubgraphRef parent, OAGSubgraphRef child, uint8_t tag) OAG_SWIFT_NAME(OAGSubgraphRef.addChild(self:_:tag:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphRemoveChild(OAGSubgraphRef parent, OAGSubgraphRef child) OAG_SWIFT_NAME(OAGSubgraphRef.removeChild(self:_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGSubgraphIntersects(OAGSubgraphRef subgraph, OAGAttributeFlags flags) OAG_SWIFT_NAME(OAGSubgraphRef.intersects(self:flags:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphApply(OAGSubgraphRef cf_subgraph,
                     OAGAttributeFlags flags,
                     const void (*function)(const void * _Nullable context OAG_SWIFT_CONTEXT, OAGAttribute attribute) OAG_SWIFT_CC(swift),
                     const void * _Nullable context);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphUpdate(OAGSubgraphRef cf_subgraph, OAGAttributeFlags flags) OAG_SWIFT_NAME(OAGSubgraphRef.update(self:flags:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGSubgraphIsDirty(OAGSubgraphRef cf_subgraph, OAGAttributeFlags flags) OAG_SWIFT_NAME(OAGSubgraphRef.isDirty(self:flags:));

typedef long OAGObserverID OAG_SWIFT_NAME(ObserverID);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGObserverID OAGSubgraphAddObserver(OAGSubgraphRef cf_subgraph,
                           const void (*function)(const void * _Nullable context OAG_SWIFT_CONTEXT) OAG_SWIFT_CC(swift),
                           const void * _Nullable context);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphRemoveObserver(OAGSubgraphRef cf_subgraph, OAGObserverID observerID) OAG_SWIFT_NAME(OAGSubgraphRef.removeObserver(self:_:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
bool OAGSubgraphShouldRecordTree(void) OAG_SWIFT_NAME(getter:OAGSubgraphRef.shouldRecordTree());

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphSetShouldRecordTree(void) OAG_SWIFT_NAME(OAGSubgraphRef.setShouldRecordTree());

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphBeginTreeElement(OAGAttribute attribute, OAGTypeID type, uint32_t flags);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphAddTreeValue(OAGAttribute attribute, OAGTypeID type, const char * key, uint32_t flags);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGSubgraphEndTreeElement(OAGAttribute attribute);

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGSubgraph_h */

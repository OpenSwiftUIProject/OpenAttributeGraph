//
//  OAGTreeElement.h
//  OpenAttributeGraphCxx

#ifndef OAGTreeElement_h
#define OAGTreeElement_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGTreeValue.h>

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

OAG_EXTERN_C_BEGIN

typedef struct _OAGTreeElement *OAGTreeElement OAG_SWIFT_STRUCT OAG_SWIFT_NAME(TreeElement);

typedef struct OAGTreeElementValueIterator {
    uintptr_t parent_elt;
    uintptr_t next_elt;
} OAG_SWIFT_NAME(Values) OAGTreeElementValueIterator;

typedef struct OAGTreeElementNodeIterator {
    uintptr_t elt;
    unsigned long node_index;
} OAG_SWIFT_NAME(Nodes) OAGTreeElementNodeIterator;

typedef struct OAGTreeElementChildIterator {
    uintptr_t parent_elt;
    uintptr_t next_elt;
    size_t subgraph_index;
} OAG_SWIFT_NAME(Children) OAGTreeElementChildIterator;

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTypeID OAGTreeElementGetType(OAGTreeElement tree_element) OAG_SWIFT_NAME(getter:OAGTreeElement.type(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGTreeElementGetValue(OAGTreeElement tree_element);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
uint32_t OAGTreeElementGetFlags(OAGTreeElement tree_element) OAG_SWIFT_NAME(getter:OAGTreeElement.flags(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTreeElement _Nullable OAGTreeElementGetParent(OAGTreeElement tree_element)
    OAG_SWIFT_NAME(getter:OAGTreeElement.parent(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTreeElementValueIterator OAGTreeElementMakeValueIterator(OAGTreeElement tree_element)
    OAG_SWIFT_NAME(getter:OAGTreeElement.values(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTreeValue _Nullable OAGTreeElementGetNextValue(OAGTreeElementValueIterator *iter)
    OAG_SWIFT_NAME(OAGTreeElementValueIterator.next(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTreeElementNodeIterator OAGTreeElementMakeNodeIterator(OAGTreeElement tree_element)
    OAG_SWIFT_NAME(getter:OAGTreeElement.nodes(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGAttribute OAGTreeElementGetNextNode(OAGTreeElementNodeIterator *iter);

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTreeElementChildIterator OAGTreeElementMakeChildIterator(OAGTreeElement tree_element)
    OAG_SWIFT_NAME(getter:OAGTreeElement.children(self:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGTreeElement _Nullable OAGTreeElementGetNextChild(OAGTreeElementChildIterator *iter)
    OAG_SWIFT_NAME(OAGTreeElementChildIterator.next(self:));

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGTreeElement_h */

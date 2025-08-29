//
//  OAGGraphDescription.h
//  OpenAttributeGraphCxx

#ifndef OAGGraphDescription_h
#define OAGGraphDescription_h

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGGraph.h>

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

OAG_EXTERN_C_BEGIN

#if OAG_OBJC_FOUNDATION

typedef CFStringRef OAGDescriptionOption OAG_SWIFT_STRUCT OAG_SWIFT_NAME(DescriptionOption);

OAG_EXPORT
const OAGDescriptionOption OAGDescriptionFormat OAG_SWIFT_NAME(DescriptionOption.format);

OAG_EXPORT
const OAGDescriptionOption OAGDescriptionIncludeValues OAG_SWIFT_NAME(DescriptionOption.includeValues);

OAG_EXPORT
const OAGDescriptionOption OAGDescriptionTruncationLimit OAG_SWIFT_NAME(DescriptionOption.truncationLimit);

OAG_EXPORT
const OAGDescriptionOption OAGDescriptionMaxFrames OAG_SWIFT_NAME(DescriptionOption.maxFrames);

static const CFStringRef OAGDescriptionFormatDot OAG_SWIFT_NAME(OAGGraphRef.descriptionFormatDot) = CFSTR("graph/dot");

static const CFStringRef OAGDescriptionFormatDictionary OAG_SWIFT_NAME(OAGGraphRef.descriptionFormatDictionary) = CFSTR("graph/dict");

static const CFStringRef OAGDescriptionAllGraphs OAG_SWIFT_NAME(OAGGraphRef.descriptionAllGraphs) = CFSTR("all_graphs");

#endif

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphArchiveJSON(char const * _Nullable name) OAG_SWIFT_NAME(OAGGraphRef.archiveJSON(name:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGGraphArchiveJSON2(char const * _Nullable name, bool exclude_values) OAG_SWIFT_NAME(OAGGraphRef.archiveJSON(name:excludeValues:));

OAG_EXPORT
OAG_REFINED_FOR_SWIFT
_Nullable CFTypeRef OAGGraphDescription(_Nullable OAGGraphRef graph, CFDictionaryRef options) OAG_SWIFT_NAME(OAGGraphRef.description(_:options:));

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAGGraphDescription_h */

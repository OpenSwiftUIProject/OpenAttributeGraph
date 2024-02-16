//
//  graph-description.hpp
//
//
//  Created by Kyle on 2024/1/21.
//

#ifndef graph_description_hpp
#define graph_description_hpp

#include "OGBase.hpp"
#include "graph.hpp"

#if TARGET_OS_DARWIN
OG_EXTERN_C_BEGIN
OG_EXPORT
CFStringRef OGDescriptionFormat;
OG_EXTERN_C_END

#endif /* TARGET_OS_DARWIN */
#endif /* graph_description_hpp */

//
//  OAGVersion.c
//  OpenAttributeGraph

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGVersion.h>

#if OPENATTRIBUTEGRAPH_RELEASE == OPENATTRIBUTEGRAPH_RELEASE_2024
const double OpenAttributeGraphVersionNumber __attribute__ ((used)) = (double)6.0;
const unsigned char OpenAttributeGraphVersionString[] __attribute__ ((used)) = "@(#)PROAGRAM:OpenAttributeGraph  PROJECT:OpenAttributeGraph-6.0.87\n";
const uint64_t OAGVersion = 0x2001e;
#elif OPENATTRIBUTEGRAPH_RELEASE == OPENATTRIBUTEGRAPH_RELEASE_2021
const double OpenAttributeGraphVersionNumber __attribute__ ((used)) = (double)3.2;
const unsigned char OpenAttributeGraphVersionString[] __attribute__ ((used)) = "@(#)PROAGRAM:OpenAttributeGraph  PROJECT:OpenAttributeGraph-3.2.1\n";
const uint64_t OAGVersion = 0x20014;
#endif

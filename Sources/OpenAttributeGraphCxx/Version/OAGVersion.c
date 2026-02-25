//
//  OAGVersion.c
//  OpenAttributeGraph

#include <OpenAttributeGraph/OAGBase.h>
#include <OpenAttributeGraph/OAGVersion.h>

#if OPENATTRIBUTEGRAPH_RELEASE == OPENATTRIBUTEGRAPH_RELEASE_2024
#if SWIFT_PACKAGE
double OpenAttributeGraphVersionNumber __attribute__ ((used)) = (double)6.5;
const unsigned char OpenAttributeGraphVersionString[] __attribute__ ((used)) = "@(#)PROAGRAM:OpenAttributeGraph  PROJECT:OpenAttributeGraph-6.5.1\n";
#endif
const uint64_t OAGVersion = 0x2001e;
#elif OPENATTRIBUTEGRAPH_RELEASE == OPENATTRIBUTEGRAPH_RELEASE_2021
#if SWIFT_PACKAGE
double OpenAttributeGraphVersionNumber __attribute__ ((used)) = (double)3.2;
const unsigned char OpenAttributeGraphVersionString[] __attribute__ ((used)) = "@(#)PROAGRAM:OpenAttributeGraph  PROJECT:OpenAttributeGraph-3.2.1\n";
#endif
const uint64_t OAGVersion = 0x20014;
#endif

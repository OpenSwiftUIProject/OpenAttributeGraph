//
//  log.hpp
//  OpenAttributeGraphCxx
//
//  Audited for 2021 Release

#ifndef log_hpp
#define log_hpp

#include <OpenAttributeGraph/OAGBase.h>

#if OAG_TARGET_OS_DARWIN

#include <os/log.h>

namespace OAG {
os_log_t misc_log();
os_log_t error_log();
} /* OAG */

#endif /* OAG_TARGET_OS_DARWIN */

#endif /* log_hpp */

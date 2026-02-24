//
//  log.hpp
//  OpenAttributeGraphCxx
//
//  Status: Complete
//  Audited for 6.5.1

#ifndef log_hpp
#define log_hpp

#include <OpenAttributeGraph/OAGBase.h>
#include <platform/log.h>

namespace OAG {
platform_log_t misc_log();
platform_log_t error_log();
} /* OAG */

#endif /* log_hpp */

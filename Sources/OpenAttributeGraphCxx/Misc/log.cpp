//
//  OAGLog.cpp
//  OpenAttributeGraphCxx
//
//  Status: Complete
//  Audited for 6.5.1

#include <OpenAttributeGraphCxx/Misc/log.hpp>

namespace OAG {
platform_log_t misc_log() {
    static platform_log_t log = platform_log_create("org.OpenSwiftUIProject.OpenAttributeGraph", "misc");
    return log;
}
platform_log_t error_log() {
    static platform_log_t log = platform_log_create("org.OpenSwiftUIProject.OpenAttributeGraph", "error");
    return log;
}
} /* OAG */

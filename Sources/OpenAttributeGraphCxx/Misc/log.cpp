//
//  OAGLog.cpp
//  OpenAttributeGraphCxx
//
//  Audited for 2021 Release

#include <OpenAttributeGraphCxx/Misc/log.hpp>

#if OAG_TARGET_OS_DARWIN

namespace OAG {
os_log_t misc_log() {
    static os_log_t log = os_log_create("org.OpenSwiftUIProject.OpenAttributeGraph", "misc");
    return log;
}
os_log_t error_log() {
    static os_log_t log = os_log_create("org.OpenSwiftUIProject.OpenAttributeGraph", "error");
    return log;
}
} /* OAG */

#endif /* OAG_TARGET_OS_DARWIN */

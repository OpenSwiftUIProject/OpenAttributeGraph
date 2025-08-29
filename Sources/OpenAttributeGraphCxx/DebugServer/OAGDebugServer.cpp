//
//  OAGDebugServer.cpp
//  OpenAttributeGraphCxx
//
//  Audited for 6.5.1
//  Status: Complete

#include <OpenAttributeGraph/OAGDebugServer.h>
#include <OpenAttributeGraphCxx/DebugServer/DebugServer.hpp>

#if OAG_TARGET_OS_DARWIN

// MARK: - Exported C functions

OAGDebugServerRef _Nullable OAGDebugServerStart(OAGDebugServerMode port) {
    return (OAGDebugServerRef)OAG::DebugServer::start(port);
}

void OAGDebugServerStop() {
    OAG::DebugServer::stop();
}

CFURLRef _Nullable OAGDebugServerCopyURL() {
    if (!OAG::DebugServer::has_shared_server()) {
        return nullptr;
    }
    return OAG::DebugServer::shared_server()->copy_url();
}

void OAGDebugServerRun(int timeout) {
    if (!OAG::DebugServer::has_shared_server()) {
        return;
    }
    OAG::DebugServer::shared_server()->run(timeout);
}

#endif

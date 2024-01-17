//
//  og-debug-server.hpp
//
//
//  Created by Kyle on 2024/1/11.
//  Audited for 2021 Release

#ifndef og_debug_server_hpp
#define og_debug_server_hpp

#include "OGBase.hpp"
#if TARGET_OS_DARWIN
#include "../Util/vector.hpp"
#include <dispatch/dispatch.h>
#include <memory>

OG_ASSUME_NONNULL_BEGIN

namespace OG {
class OGDebugServerMessageHeader {
    
};
class DebugServer {
    class Connection {
    private:
        DebugServer *server;
        int descriptor;
        dispatch_source_t source;
    public:
        Connection(DebugServer *server,int descriptor);
        ~Connection();
        static void handler(void *_Nullable context); // TODO
        friend class DebugServer;
    };
private:
    int32_t fd;
    uint32_t ip;
    uint32_t port;
    uint32_t token;
    _Nullable dispatch_source_t source;
    OG::vector<std::unique_ptr<Connection>, 0, unsigned long> connections;
public:
    static DebugServer *_Nullable _shared_server;
    static DebugServer *_Nullable start(unsigned int port);
    static void stop();
    DebugServer(unsigned int port);
    ~DebugServer();
    void run(int descriptor);
    static void accept_handler(void *_Nullable context);
    CFURLRef _Nullable copy_url() const;
    void shutdown();
    
    __CFData *_Nullable receive(Connection *connection, OGDebugServerMessageHeader &header, __CFData *data);
    void close_connection(Connection *connection);
};
}


// MARK: - Exported C functions

OG_EXTERN_C_BEGIN
OG_EXPORT
OG::DebugServer* _Nullable OGDebugServerStart(unsigned int port);
OG_EXPORT
void OGDebugServerStop();
OG_EXPORT
CFURLRef _Nullable OGDebugServerCopyURL();
OG_EXPORT
void OGDebugServerRun(int timeout);
OG_EXTERN_C_END

OG_ASSUME_NONNULL_END

#endif /* TARGET_OS_DARWIN */
#endif /* og_debug_server_ hpp */

//
//  DebugServer.hpp
//  OpenAttributeGraphCxx
//
//  Audited for 6.5.1
//  Status: Complete

#ifndef OPENATTRIBUTEGRAPH_CXX_DEBUGSERVER_DEBUGSERVER_HPP
#define OPENATTRIBUTEGRAPH_CXX_DEBUGSERVER_DEBUGSERVER_HPP

#include <OpenAttributeGraph/OAGBase.h>
#if OAG_TARGET_OS_DARWIN
#include <OpenAttributeGraph/OAGDebugServer.h>
#include <OpenAttributeGraphCxx/Vector/vector.hpp>
#include <dispatch/dispatch.h>
#include <memory>
#include <swift/bridging>

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

/// Message header structure for debug server communication protocol.
/// Contains metadata for messages exchanged between the debug server and clients.
typedef struct OAG_SWIFT_NAME(DebugServerMessageHeader) OAGDebugServerMessageHeader {
    /// Authentication token for the message
    uint32_t token;
    /// Reserved field for future use
    uint32_t unknown;
    /// Length of the message payload in bytes
    uint32_t length;
    /// Additional reserved field for protocol extensions
    uint32_t unknown2;
} OAGDebugServerMessageHeader; /* OAGDebugServerMessageHeader */

namespace OAG {

/// Debug server for OpenAttributeGraph runtime inspection and debugging.
/// 
/// The DebugServer provides a network interface for external tools to connect
/// and inspect the internal state of OpenAttributeGraph. It supports both listening for
/// incoming connections and handling client requests for graph data.
///
/// The server operates in different modes as specified by OAGDebugServerMode
/// and manages multiple concurrent client connections using GCD dispatch sources.
class DebugServer {
public:
    /// Creates a new debug server instance with the specified mode.
    ///
    /// @param mode The operating mode for the debug server
    DebugServer(OAGDebugServerMode mode);
    
    /// Move constructor for transferring ownership of server resources.
    ///
    /// @param other The DebugServer instance to move from
    DebugServer(DebugServer&& other) OAG_NOEXCEPT;
    
    /// Move assignment operator for transferring ownership of server resources.
    ///
    /// @param other The DebugServer instance to move from
    /// @return Reference to this instance after the move
    DebugServer& operator=(DebugServer&& other) OAG_NOEXCEPT;
    
    /// Deleted copy constructor to prevent accidental copying.
    DebugServer(const DebugServer&) = delete;
    
    /// Deleted copy assignment operator to prevent accidental copying.
    DebugServer& operator=(const DebugServer&) = delete;

    /// Destroys the debug server and cleans up all resources.
    /// Automatically closes all active connections and stops the server.
    ~DebugServer();

    /// Returns a copy of the URL where the debug server is accessible.
    ///
    /// @return A CFURLRef containing the server URL, or nullptr if not running.
    ///         The caller is responsible for releasing the returned URL.
    CFURLRef _Nullable copy_url() const SWIFT_RETURNS_INDEPENDENT_VALUE;

    /// Shuts down the debug server and closes all connections.
    /// Called internally during destruction or explicit stop.
    void shutdown();

    /// Runs the debug server for the specified timeout duration.
    ///
    /// @param timeout Maximum time in seconds to run the server.
    ///                Use -1 for indefinite operation.
    void run(int timeout) const;

    /// Returns the shared debug server instance.
    ///
    /// @return Pointer to the shared server, or nullptr if none exists
    static OAG_INLINE DebugServer *shared_server() { return _shared_server; }
    
    /// Checks if a shared debug server instance exists.
    ///
    /// @return true if a shared server is active, false otherwise
    static OAG_INLINE bool has_shared_server() { return _shared_server != nullptr; }

    /// Starts a new shared debug server with the specified mode.
    ///
    /// @param mode Configuration flags controlling server behavior.
    ///             Must include OAGDebugServerModeValid for basic operation.
    /// @return Pointer to the started server, or nullptr if startup failed
    static DebugServer *_Nullable start(OAGDebugServerMode mode);
    
    /// Stops the shared debug server and releases all resources.
    /// This will close all client connections and shut down the server.
    static void stop();

private:
    /// Represents a single client connection to the debug server.
    ///
    /// Each Connection manages its own socket descriptor and dispatch source
    /// for handling incoming data from a connected client. Connections are
    /// automatically cleaned up when the client disconnects.
    class Connection {
    public:
        /// Creates a new connection for the specified server and socket.
        ///
        /// @param server The debug server that owns this connection
        /// @param descriptor The socket file descriptor for the client
        Connection(DebugServer *server,int descriptor);
        
        /// Destroys the connection and cleans up resources.
        /// Automatically closes the socket and cancels the dispatch source.
        ~Connection();

        /// Static handler function for processing incoming connection data.
        ///
        /// @param context Pointer to the Connection instance
        static void handler(void *_Nullable context);

        friend class DebugServer;
    private:
        DebugServer *server;          ///< Owning debug server
        int sockfd;                   ///< Client socket file descriptor
        dispatch_source_t source;     ///< GCD source for socket events
    }; /* Connection */

    /// Receives and processes a message from the specified connection.
    ///
    /// @param connection The client connection to receive from
    /// @param header Reference to store the received message header
    /// @param data Existing data buffer to append to, or nullptr for new data
    /// @return CFDataRef containing the complete message, or nullptr on error
    CFDataRef _Nullable receive(Connection *connection, OAGDebugServerMessageHeader &header, CFDataRef data);
    
    /// Closes and removes the specified client connection.
    ///
    /// @param connection The connection to close and clean up
    void close_connection(Connection *connection);

    /// Static handler for accepting new client connections.
    ///
    /// @param context Pointer to the DebugServer instance
    static void accept_handler(void *_Nullable context);

    int32_t sockfd;                                                         ///< Server socket file descriptor
    uint32_t ip;                                                           ///< Server IP address
    uint32_t port;                                                         ///< Server port number
    uint32_t token;                                                        ///< Authentication token
    _Nullable dispatch_source_t source;                                    ///< GCD source for accepting connections
    OAG::vector<std::unique_ptr<Connection>, 0, u_long> connections;        ///< Active client connections

    static DebugServer *_Nullable _shared_server;                          ///< Global shared server instance
}; /* DebugServer */

} /* OAG */

/// C-compatible storage wrapper for DebugServer instances.
/// 
/// This structure provides a C-compatible interface for storing
/// DebugServer objects in contexts where C++ objects cannot be
/// used directly.
typedef struct OAGDebugServerStorage {
    OAG::DebugServer debugServer;    ///< The wrapped DebugServer instance
} OAGDebugServerStorage;

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif /* OAG_TARGET_OS_DARWIN */
#endif /* OPENATTRIBUTEGRAPH_CXX_DEBUGSERVER_DEBUGSERVER_HPP */

//
//  OAGDebugServer.h
//  OpenAttributeGraphCxx
//
//  Audited for 6.5.1
//  Status: Complete

#ifndef OAGDebugServer_h
#define OAGDebugServer_h

#include <OpenAttributeGraph/OAGBase.h>

#if OAG_TARGET_OS_DARWIN

/**
 * @header OAGDebugServer.h
 * @abstract OpenAttributeGraph Debug Server API for runtime debugging and inspection.
 * @discussion The debug server provides runtime debugging capabilities for OpenAttributeGraph applications,
 * allowing external tools to connect and inspect graph state, dependencies, and execution.
 * This API is only available on Darwin platforms and requires network interface access
 * when used in network mode.
 */

OAG_ASSUME_NONNULL_BEGIN

OAG_IMPLICIT_BRIDGING_ENABLED

/**
 * @typedef OAGDebugServerRef
 * @abstract An opaque reference to a debug server instance.
 * @discussion The debug server manages a connection endpoint that external debugging tools
 * can use to inspect OpenAttributeGraph runtime state. Only one debug server instance
 * can be active at a time.
 */
typedef struct OAGDebugServerStorage *OAGDebugServerRef OAG_SWIFT_STRUCT OAG_SWIFT_NAME(DebugServer);

/**
 * @typedef OAGDebugServerMode
 * @abstract Configuration modes for the debug server.
 * @discussion These flags control how the debug server operates and what interfaces it exposes.
 * Multiple modes can be combined using bitwise OR operations.
 */
typedef OAG_OPTIONS(uint32_t, OAGDebugServerMode) {
    /**
     * @abstract No debug server functionality.
     * @discussion Use this mode to disable all debug server operations.
     */
    OAGDebugServerModeNone = 0,
    
    /**
     * @abstract Enable basic debug server validation and setup.
     * @discussion This mode enables the debug server with minimal functionality and is required 
     * for any debug server operation. All other modes must be combined with this flag.
     */
    OAGDebugServerModeValid = 1 << 0,
    
    /**
     * @abstract Enable network interface for remote debugging.
     * @discussion When enabled, the debug server will listen on a network interface, allowing 
     * remote debugging tools to connect. Requires OAGDebugServerModeValid to be set.
     */
    OAGDebugServerModeNetworkInterface = 1 << 1,
} OAG_SWIFT_NAME(OAGDebugServerRef.Mode);

// MARK: - Exported C functions

OAG_EXTERN_C_BEGIN

/**
 * @function OAGDebugServerStart
 * @abstract Starts the shared debug server with the specified mode.
 * @discussion Creates and starts a new shared debug server instance. If a server is already
 * running, this function will return the existing instance.
 * 
 * The returned reference should not be manually managed. Use OAGDebugServerStop()
 * to properly shut down the shared server.
 * @param mode Configuration flags controlling server behavior.
 *             Must include OAGDebugServerModeValid for basic operation.
 * @result A reference to the started shared debug server, or NULL if the server
 *         could not be started (e.g., due to network permissions, conflicts, or existing server).
 */
OAG_EXPORT
OAG_REFINED_FOR_SWIFT
OAGDebugServerRef _Nullable OAGDebugServerStart(OAGDebugServerMode mode) OAG_SWIFT_NAME(OAGDebugServerRef.start(mode:));

/**
 * @function OAGDebugServerStop
 * @abstract Stops and deletes the running shared debug server.
 * @discussion Shuts down the active shared debug server instance and cleans up all associated
 * resources. If no shared debug server is currently running, this function has no effect.
 * 
 * This function should be called before application termination to ensure
 * proper cleanup of network resources and connections.
 */
OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGDebugServerStop(void) OAG_SWIFT_NAME(OAGDebugServerRef.stop());

/**
 * @function OAGDebugServerCopyURL
 * @abstract Returns the URL for connecting to the shared debug server.
 * @discussion Returns the URL that external debugging tools should use to connect to
 * the currently running shared debug server. The URL format depends on the server
 * configuration and may be a local or network address.
 * 
 * The returned URL is only valid while the shared debug server is running.
 * It may change if the server is restarted.
 * @result A CFURLRef containing the connection URL, or NULL if no shared debug server
 *         is currently running or if the server doesn't expose a connectable interface.
 *         The caller is responsible for releasing the returned URL.
 */
OAG_EXPORT
OAG_REFINED_FOR_SWIFT
CFURLRef _Nullable OAGDebugServerCopyURL(void) OAG_SWIFT_NAME(OAGDebugServerRef.copyURL());

/**
 * @function OAGDebugServerRun
 * @abstract Runs the shared debug server event loop.
 */
OAG_EXPORT
OAG_REFINED_FOR_SWIFT
void OAGDebugServerRun(int timeout) OAG_SWIFT_NAME(OAGDebugServerRef.run(timeout:));

OAG_EXTERN_C_END

OAG_IMPLICIT_BRIDGING_DISABLED

OAG_ASSUME_NONNULL_END

#endif

#endif /* OAGDebugServer_h */

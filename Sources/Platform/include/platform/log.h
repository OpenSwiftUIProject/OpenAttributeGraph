#pragma once

#if __APPLE__
#include <os/log.h>
#else
#include <syslog.h>
#endif

#include <platform/base.h>

PLATFORM_ASSUME_NONNULL_BEGIN
PLATFORM_EXTERN_C_BEGIN

#if __APPLE__

typedef os_log_t platform_log_t;

#define platform_log_create(subsystem, category) ({ (platform_log_t)os_log_create(subsystem, category); })

#define platform_log_info(log, format, ...) ({ (void)os_log_info(log, format, ##__VA_ARGS__); })
#define platform_log_error(log, format, ...) ({ (void)os_log_error(log, format, ##__VA_ARGS__); })
#define platform_log_fault(log, format, ...) ({ (void)os_log_fault(log, format, ##__VA_ARGS__); })

#else

typedef struct platform_log_s *platform_log_t;

PLATFORM_ENUM(platform_log_type, uint8_t,
    PLATFORM_LOG_TYPE_DEFAULT = 0x00,
    PLATFORM_LOG_TYPE_INFO    = 0x01,
    PLATFORM_LOG_TYPE_DEBUG   = 0x02,
    PLATFORM_LOG_TYPE_ERROR   = 0x10,
    PLATFORM_LOG_TYPE_FAULT   = 0x11,
);

PLATFORM_EXPORT
platform_log_t platform_log_create(const char *subsystem, const char *category);

#define platform_log_info(log, format, ...) \
    _platform_log_impl(log, PLATFORM_LOG_TYPE_INFO, (format), ##__VA_ARGS__)

#define platform_log_error(log, format, ...) \
    _platform_log_impl(log, PLATFORM_LOG_TYPE_ERROR, (format), ##__VA_ARGS__)

#define platform_log_fault(log, format, ...) \
    _platform_log_impl(log, PLATFORM_LOG_TYPE_FAULT, (format), ##__VA_ARGS__)

PLATFORM_EXPORT
void _platform_log_impl(platform_log_t log, platform_log_type_t type,
        const char *format, ...);

#endif

PLATFORM_EXTERN_C_END
PLATFORM_ASSUME_NONNULL_END

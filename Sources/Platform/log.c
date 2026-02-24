#include "platform/log.h"

#if !__APPLE__

#include <malloc.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>

struct platform_log_s {
    char *subsystem;
    char *category;
};

platform_log_t platform_log_create(const char *subsystem, const char *category) {
    platform_log_t log = malloc(sizeof(struct platform_log_s));
    if (subsystem) {
        log->subsystem = strdup(subsystem);
    } else {
        log->subsystem = NULL;
    }
    if (category) {
        log->category = strdup(category);
    } else {
        log->category = NULL;
    }
    return log;
}

void platform_log_destroy(platform_log_t log) {
    if (log) {
        if (log->subsystem) {
            free(log->subsystem);
        }
        if (log->category) {
            free(log->category);
        }
        free(log);
    }
}

void _platform_log_impl(platform_log_t log, platform_log_type_t type, const char *format, ...) {
    char *message = NULL;

    va_list args;
    va_start(args, format);
    vasprintf(&message, format, args);
    va_end(args);

    if (message) {
        openlog(log->subsystem, LOG_CONS | LOG_PID | LOG_NDELAY, LOG_USER);
        if (type >= PLATFORM_LOG_TYPE_FAULT) {
            syslog(LOG_CRIT, "%s", message);
        } else if (type >= PLATFORM_LOG_TYPE_ERROR) {
            syslog(LOG_ERR, "%s", message);
        } else {
            syslog(LOG_INFO, "%s", message);
        }
        closelog();
        free(message);
    }
}

#endif

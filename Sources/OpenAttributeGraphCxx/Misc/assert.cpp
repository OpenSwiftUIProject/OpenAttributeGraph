//
//  assert.cpp
//  OpenAttributeGraphCxx

#include <OpenAttributeGraphCxx/Misc/assert.hpp>
#include <OpenAttributeGraphCxx/Misc/log.hpp>
#include <OpenAttributeGraphCxx/Graph/Graph.hpp>

#include <stdio.h>
#include <stdlib.h>

static char* error_message = nullptr;

namespace OAG {
void precondition_failure(const char *format, ...) {
    char* s = nullptr;
    va_list va;
    va_start(va, format);
    vasprintf(&s, format, va);
    va_end(va);
    if (s != nullptr) {
        platform_log_error(error_log(), "precondition failure: %s", s);
        Graph::trace_assertion_failure(true, "precondition failure: %s", s);
        if (error_message == nullptr) {
            asprintf(&error_message, "OpenAttributeGraph precondition failure: %s.\n", s);
        }
        free(s);
    }
    abort();
}

void non_fatal_precondition_failure(const char *format, ...) {
    char* s = nullptr;
    va_list va;
    va_start(va, format);
    vasprintf(&s, format, va);
    va_end(va);
    if (s != nullptr) {
        platform_log_fault(error_log(), "precondition failure: %s", s);
        Graph::trace_assertion_failure(false, "precondition failure: %s", s);
        free(s);
    }
}
} /* OAG */

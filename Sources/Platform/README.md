## Platform

Cross-platform abstraction layer providing core system services.

### Contents

- **log** - Logging abstraction using `os_log` on Darwin and POSIX syslog on other platforms
- **malloc** - Memory allocation abstraction using `malloc_zone_*` on Darwin and standard `malloc` shims on other platforms

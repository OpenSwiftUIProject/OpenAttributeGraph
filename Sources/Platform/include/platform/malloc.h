#pragma once

#if __APPLE__
#include <malloc/malloc.h>
#else

#include <malloc.h>

typedef int malloc_zone_t;

#define malloc_zone_malloc(zone,size) malloc(size)
#define malloc_zone_memalign(zone,align,size) malloc(size)
#define malloc_zone_calloc(zone,count,size) calloc(count,size)
#define malloc_zone_realloc(zone,ptr,size) realloc(ptr,size)
#define malloc_zone_free(zone,ptr) free(ptr)

#define malloc_size(ptr) malloc_usable_size(ptr)
#define malloc_good_size(size) (size)

#define malloc_create_zone(a,b) ((malloc_zone_t *)NULL)
#define malloc_destroy_zone(zone)
#define malloc_set_zone_name(zone,name)

#endif

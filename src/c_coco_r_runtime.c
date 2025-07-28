#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>
#include <stdarg.h>
#include <string.h>

#include "coco.h"

/* Global log level variable for R runtime */
coco_log_level_type_e coco_log_level = COCO_INFO;

/**
 * R analog of coco_error - uses R error handling instead of exit()
 */
void coco_error(const char *message, ...) {
  va_list args;
  char buffer[1024];
  
  strcpy(buffer, "COCO FATAL ERROR: ");
  va_start(args, message);
  vsnprintf(buffer + strlen(buffer), sizeof(buffer) - strlen(buffer), message, args);
  va_end(args);
  
  Rf_error("%s", buffer);
}

/**
 * R analog of coco_warning - uses Rprintf instead of fprintf
 */
void coco_warning(const char *message, ...) {
  va_list args;

  if (coco_log_level >= COCO_WARNING) {
    Rprintf("COCO WARNING: ");
    va_start(args, message);
    Rvprintf(message, args);
    va_end(args);
    Rprintf("\n");
  }
}

/**
 * R analog of coco_info - uses Rprintf instead of fprintf
 */
void coco_info(const char *message, ...) {
  va_list args;

  if (coco_log_level >= COCO_INFO) {
    Rprintf("COCO INFO: ");
    va_start(args, message);
    Rvprintf(message, args);
    va_end(args);
    Rprintf("\n");
  }
}

/**
 * R analog of coco_info_partial - uses Rprintf instead of fprintf
 */
void coco_info_partial(const char *message, ...) {
  va_list args;

  if (coco_log_level >= COCO_INFO) {
    va_start(args, message);
    Rvprintf(message, args);
    va_end(args);
  }
}

/**
 * R analog of coco_debug - uses Rprintf instead of fprintf
 */
void coco_debug(const char *message, ...) {
  va_list args;

  if (coco_log_level >= COCO_DEBUG) {
    Rprintf("COCO DEBUG: ");
    va_start(args, message);
    Rvprintf(message, args);
    va_end(args);
    Rprintf("\n");
  }
}

/**
 * R analog of coco_allocate_memory - uses R_Calloc for persistent allocations
 */
void *coco_allocate_memory(const size_t size) {
  if (size == 0) {
    coco_error("coco_allocate_memory() called with 0 size.");
    return NULL; /* never reached */
  }
  return R_Calloc(size, char);
}

/**
 * R analog of coco_free_memory - uses R_Free for persistent allocations
 */
void coco_free_memory(void *data) {
  if (data != NULL) {
    R_Free(data);
  }
}

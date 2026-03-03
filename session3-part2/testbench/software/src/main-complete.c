#include <stdint.h>

volatile uint8_t* VIRTUAL_DEBUG_ADDRESS = (volatile uint8_t*) 0xC0000000;

char *logorv =
    "\n"
    "              vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv\n"
    "                  vvvvvvvvvvvvvvvvvvvvvvvvvvvv\n"
    "rrrrrrrrrrrrr       vvvvvvvvvvvvvvvvvvvvvvvvvv\n"
    "rrrrrrrrrrrrrrrr      vvvvvvvvvvvvvvvvvvvvvvvv\n"
    "rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv\n"
    "rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv\n"
    "rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv\n"
    "rrrrrrrrrrrrrrrr      vvvvvvvvvvvvvvvvvvvvvv  \n"
    "rrrrrrrrrrrrr       vvvvvvvvvvvvvvvvvvvvvv    \n"
    "rr                vvvvvvvvvvvvvvvvvvvvvv      \n"
    "rr            vvvvvvvvvvvvvvvvvvvvvvvv      rr\n"
    "rrrr      vvvvvvvvvvvvvvvvvvvvvvvvvv      rrrr\n"
    "rrrrrr      vvvvvvvvvvvvvvvvvvvvvv      rrrrrr\n"
    "rrrrrrrr      vvvvvvvvvvvvvvvvvv      rrrrrrrr\n"
    "rrrrrrrrrr      vvvvvvvvvvvvvv      rrrrrrrrrr\n"
    "rrrrrrrrrrrr      vvvvvvvvvv      rrrrrrrrrrrr\n"
    "rrrrrrrrrrrrrr      vvvvvv      rrrrrrrrrrrrrr\n"
    "rrrrrrrrrrrrrrrr      vv      rrrrrrrrrrrrrrrr\n"
    "rrrrrrrrrrrrrrrrrr          rrrrrrrrrrrrrrrrrr\n"
    "rrrrrrrrrrrrrrrrrrrr      rrrrrrrrrrrrrrrrrrrr\n"
    "rrrrrrrrrrrrrrrrrrrrrr  rrrrrrrrrrrrrrrrrrrrrr\n"
    "\n"
    "       INSTRUCTION SETS WANT TO BE FREE\n\n"
    "              Hello from Hazard3!      \n\n";

uint32_t basic_printf(const uint8_t *str) {
    while (*str) *VIRTUAL_DEBUG_ADDRESS = *str++;
    return 0;
}

int main(void) {
    basic_printf(logorv);
    return 0;
}

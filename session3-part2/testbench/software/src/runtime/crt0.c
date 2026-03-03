/*
 *  From https://www.southampton.ac.uk/~bim/notes/cad/lab/system_on_chip/riscv_system_on_programmable_chip.php
 */

#include <stdint.h>

extern uint32_t _sbss;
extern uint32_t _ebss;
extern uint32_t _sdata;
extern uint32_t _edata;
extern uint32_t _etext;

extern int main(void);

void ResetHandler(void) {
    uint32_t *pDest;
    uint32_t *pSrc;

    /* Initialised data must be copied from ROM to RAM before calling main */
    pSrc = &_etext;
    pDest = &_sdata;
    if (pSrc != pDest) {
        /* this will only be run if there is any read-only memory */
        while (pDest < &_edata) {
            *pDest++ = *pSrc++;
        }
    }

    /* BSS segment (if it exists) must be cleared before calling main */
    pDest = &_sbss;
    while (pDest < &_ebss) {
        *pDest++ = 0;
    }

    main();

    while (1) {};
}

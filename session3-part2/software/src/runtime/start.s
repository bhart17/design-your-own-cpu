/*
 *  From https://www.southampton.ac.uk/~bim/notes/cad/lab/system_on_chip/riscv_system_on_programmable_chip.php
 */

.section .reset.text, "ax"
.global _start
_start:
    .cfi_startproc
    .cfi_undefined ra
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop
    la sp, _estack
    mv s0, sp
    j ResetHandler
    .cfi_endproc
    .end

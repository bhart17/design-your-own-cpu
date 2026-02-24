// This package defines RISC-V specific instruction encodings

`ifndef RISCV_OPCODES_PKG_SVH
`define RISCV_OPCODES_PKG_SVH

package riscv_opcodes_pkg;

    typedef enum logic [6:0] {
        OPCODE_LOAD     = 7'b0000011,
        OPCODE_MISC_MEM = 7'b0001111,
        OPCODE_OP_IMM   = 7'b0010011,
        OPCODE_AUIPC    = 7'b0010111,
        OPCODE_STORE    = 7'b0100011,
        OPCODE_OP       = 7'b0110011,
        OPCODE_LUI      = 7'b0110111,
        OPCODE_BRANCH   = 7'b1100011,
        OPCODE_JALR     = 7'b1100111,
        OPCODE_JAL      = 7'b1101111,
        OPCODE_SYSTEM   = 7'b1110011
    } riscv_opcode_t;

    typedef enum logic [2:0] {
        FUNCT3_ADD_SUB = 3'b000,
        FUNCT3_SLL     = 3'b001,
        FUNCT3_SLT     = 3'b010,
        FUNCT3_SLTU    = 3'b011,
        FUNCT3_XOR     = 3'b100,
        FUNCT3_SRL_SRA = 3'b101,
        FUNCT3_OR      = 3'b110,
        FUNCT3_AND     = 3'b111
    } riscv_arith_funct3_t;

    typedef enum logic [2:0] {
        FUNCT3_BEQ  = 3'b000,
        FUNCT3_BNE  = 3'b001,
        FUNCT3_BLT  = 3'b100,
        FUNCT3_BGE  = 3'b101,
        FUNCT3_BLTU = 3'b110,
        FUNCT3_BGEU = 3'b111
    } riscv_branch_funct3_t;

    typedef enum logic [2:0] {
        FUNCT3_BYTE  = 3'b000,
        FUNCT3_HALF  = 3'b001,
        FUNCT3_WORD  = 3'b010,
        FUNCT3_BYTEU = 3'b100,
        FUNCT3_HALFU = 3'b101
    } riscv_load_store_funct3_t;

    typedef enum logic [6:0] {
        FUNCT7_DEFAULT = 7'b0000000,
        FUNCT7_ALT     = 7'b0100000
    } riscv_funct7_t;

endpackage

`endif

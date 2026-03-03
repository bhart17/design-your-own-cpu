`ifndef ENUMS_PKG_SVH
`define ENUMS_PKG_SVH

package enums_pkg;

    typedef enum logic [3:0] {
        ALU_ADD,
        ALU_SUB,
        ALU_SUBU,
        ALU_SLL, // shift left logical (<<)
        ALU_SLT, // set on less than
        ALU_SLTU, // set on less than unsigned
        ALU_XOR, // xor (^)
        ALU_SRL, // shift right logical (>>)
        ALU_SRA, // shift right arithmetic (>>>)
        ALU_OR, // or (|)
        ALU_AND, // and (&)
        ALU_PASS_B
    } alu_op_t;

    typedef enum logic [2:0] {
        BRANCH_NEVER,
        BRANCH_ALWAYS,
        BRANCH_EQ,
        BRANCH_NE,
        BRANCH_LT,
        BRANCH_GE
    } branch_op_t;

    typedef enum logic [2:0] {
        MEM_BYTE,
        MEM_BYTEU,
        MEM_HALF,
        MEM_HALFU,
        MEM_WORD
    } mem_size_t;

endpackage

`endif

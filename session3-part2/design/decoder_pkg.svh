`ifndef DECODER_PKG_SVH
`define DECODER_PKG_SVH

package decoder_pkg;

    import riscv_opcodes_pkg::*;

    function automatic riscv_opcode_t get_opcode(logic [31:0] instruction);
        return riscv_opcode_t'(instruction[6:0]);
    endfunction

    function automatic [4:0] get_rs1(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        if (opcode inside {
            OPCODE_LOAD,
            OPCODE_MISC_MEM,
            OPCODE_OP_IMM,
            OPCODE_STORE,
            OPCODE_OP,
            OPCODE_BRANCH,
            OPCODE_JALR,
            OPCODE_SYSTEM
        }) return instruction[19:15];
        return '0;
    endfunction

    function automatic [4:0] get_rs2(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        if (opcode inside {OPCODE_STORE, OPCODE_OP, OPCODE_BRANCH}) return instruction[24:20];
        return '0;
    endfunction

    function automatic [4:0] get_rd(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        if (opcode inside {
            OPCODE_LOAD,
            OPCODE_MISC_MEM,
            OPCODE_OP_IMM,
            OPCODE_AUIPC,
            OPCODE_OP,
            OPCODE_LUI,
            OPCODE_JALR,
            OPCODE_JAL,
            OPCODE_SYSTEM
        }) return instruction[11:7];
        return '0;
    endfunction

    function automatic [31:0] get_immediate(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        case (opcode)
            OPCODE_LOAD, OPCODE_MISC_MEM, OPCODE_OP_IMM,
            OPCODE_JALR, OPCODE_SYSTEM: return {{20{instruction[31]}}, instruction[31:20]};

            OPCODE_AUIPC, OPCODE_LUI: return {instruction[31:12], 12'd0};

            OPCODE_STORE: return {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

            OPCODE_BRANCH: return {
                {20{instruction[31]}},
                instruction[7],
                instruction[30:25],
                instruction[11:8],
                1'b0
            };

            OPCODE_JAL: return {
                {12{instruction[31]}},
                instruction[19:12],
                instruction[20],
                instruction[30:21],
                1'b0
            };

            default: return '0;
        endcase
    endfunction

    function automatic riscv_arith_funct3_t get_funct3_arith(logic [31:0] instruction);
        return riscv_arith_funct3_t'(instruction[14:12]);
    endfunction

    function automatic riscv_branch_funct3_t get_funct3_branch(logic [31:0] instruction);
        return riscv_branch_funct3_t'(instruction[14:12]);
    endfunction

    function automatic riscv_load_store_funct3_t get_funct3_load_store(logic [31:0] instruction);
        return riscv_load_store_funct3_t'(instruction[14:12]);
    endfunction

    function automatic riscv_funct7_t get_funct7(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        if (opcode == OPCODE_OP) return riscv_funct7_t'(instruction[31:25]);
        return riscv_funct7_t'('0);
    endfunction

endpackage

`endif

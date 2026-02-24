`ifndef CONTROL_PKG_SVH
`define CONTROL_PKG_SVH

package control_pkg;

    import riscv_opcodes_pkg::*;
    import enums_pkg::*;
    import decoder_pkg::*;

    function automatic get_halt(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        return (opcode == OPCODE_SYSTEM);
    endfunction

    function automatic alu_op_t get_alu_op(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        case (opcode)

            OPCODE_OP, OPCODE_OP_IMM: begin
                riscv_funct7_t funct7 = get_funct7(instruction);
                case (get_funct3_arith(instruction))
                    FUNCT3_ADD_SUB: return ((funct7 == FUNCT7_ALT) && (opcode == OPCODE_OP)) ? ALU_SUB : ALU_ADD;
                    FUNCT3_SLL: return ALU_SLL;
                    FUNCT3_SLT: return ALU_SLT;
                    FUNCT3_SLTU: return ALU_SLTU;
                    FUNCT3_XOR: return ALU_XOR;
                    FUNCT3_SRL_SRA: return (funct7 == FUNCT7_ALT) ? ALU_SRA : ALU_SRL;
                    FUNCT3_OR: return ALU_OR;
                    FUNCT3_AND: return ALU_AND;
                    default: return ALU_ADD;
                endcase
            end

            OPCODE_LUI: return ALU_PASS_B;

            OPCODE_BRANCH: begin
                case (get_funct3_branch(instruction))
                    FUNCT3_BEQ, FUNCT3_BNE,
                    FUNCT3_BLT, FUNCT3_BGE: return ALU_SUB;
                    FUNCT3_BLTU, FUNCT3_BGEU: return ALU_SUBU;
                    default: return ALU_ADD;
                endcase
            end

            default: return ALU_ADD;
        endcase
    endfunction

    function automatic branch_op_t get_branch_op(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        case (opcode)
            OPCODE_JAL, OPCODE_JALR: return BRANCH_ALWAYS;
            OPCODE_BRANCH: begin
                riscv_branch_funct3_t funct3 = get_funct3_branch(instruction);
                case (funct3)
                    FUNCT3_BEQ: return BRANCH_EQ;
                    FUNCT3_BNE: return BRANCH_NE;
                    FUNCT3_BLT, FUNCT3_BLTU: return BRANCH_LT;
                    FUNCT3_BGE, FUNCT3_BGEU: return BRANCH_GE;
                    default: return BRANCH_NEVER;
                endcase
            end
            default: return BRANCH_NEVER;
        endcase
    endfunction

    function automatic mem_size_t get_memory_size(logic [31:0] instruction);
        riscv_load_store_funct3_t funct3;
        funct3 = get_funct3_load_store(instruction);
        case (funct3)
            FUNCT3_BYTE:  return MEM_BYTE;
            FUNCT3_BYTEU: return MEM_BYTEU;
            FUNCT3_HALF:  return MEM_HALF;
            FUNCT3_HALFU: return MEM_HALFU;
            default:      return MEM_WORD;
        endcase
    endfunction

    function automatic get_rd_write_enable(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        return (opcode inside {
            OPCODE_LOAD,
            OPCODE_MISC_MEM,
            OPCODE_OP_IMM,
            OPCODE_AUIPC,
            OPCODE_OP,
            OPCODE_LUI,
            OPCODE_JALR,
            OPCODE_JAL,
            OPCODE_SYSTEM
        });
    endfunction

    function automatic get_memory_read_enable(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        // Fix this control function
        return 1'b0;
    endfunction

    function automatic get_memory_write_enable(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        // Fix this control function
        return 1'b0;
    endfunction

    function automatic select_pc_alu(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        return (opcode inside {OPCODE_AUIPC, OPCODE_JALR, OPCODE_JAL});
    endfunction

    function automatic select_immediate_alu(logic [31:0] instruction);
        riscv_opcode_t opcode;
        opcode = get_opcode(instruction);
        return (opcode inside {OPCODE_LOAD, OPCODE_OP_IMM, OPCODE_AUIPC, OPCODE_STORE, OPCODE_LUI});
    endfunction

    function automatic select_memory_wb(logic [31:0] instruction);
        return get_memory_read_enable(instruction);
    endfunction

endpackage

`endif

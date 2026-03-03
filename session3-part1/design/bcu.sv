module bcu (
    input  enums_pkg::branch_op_t        branch_op,
    input  logic                  [31:0] PC,
    input  logic                  [31:0] immediate,
    input  logic                         alu_zero,
    input  logic                         alu_negative,
    output logic                  [31:0] PC_next
);

    timeunit 1ns; timeprecision 100ps;

    import enums_pkg::*;

    logic [31:0] branch_calc;
    logic [31:0] pc_plus_4;

    assign branch_calc = PC + immediate;
    assign pc_plus_4   = PC + 32'd4;

    always_comb begin
        case (branch_op)
            BRANCH_ALWAYS: PC_next = branch_calc;
            BRANCH_EQ:     PC_next = (alu_zero) ? branch_calc : pc_plus_4;
            BRANCH_NE:     PC_next = (alu_zero) ? pc_plus_4 : branch_calc;
            BRANCH_LT:     PC_next = (alu_negative) ? branch_calc : pc_plus_4;
            BRANCH_GE:     PC_next = (alu_negative) ? pc_plus_4 : branch_calc;
            default:       PC_next = pc_plus_4;
        endcase
    end

endmodule

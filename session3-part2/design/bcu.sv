module bcu (
    input  enums_pkg::branch_op_t        branch_op,
    input  logic                  [31:0] PC_fetch,
    input  logic                  [31:0] PC_exe,
    input  logic                  [31:0] immediate,
    input  logic                         alu_zero,
    input  logic                         alu_negative,
    output logic                  [31:0] PC_next,
    output logic                         branch_taken
);

    timeunit 1ns; timeprecision 100ps;

    import enums_pkg::*;

    logic [31:0] branch_calc;
    logic [31:0] pc_plus_4;

    assign branch_calc = PC_exe + immediate;
    assign pc_plus_4   = PC_fetch + 32'd4;

    always_comb begin
        case (branch_op)
            BRANCH_ALWAYS: begin
                branch_taken = 1'b1;
                PC_next = branch_calc;
            end
            BRANCH_EQ: begin
                branch_taken = alu_zero;
                PC_next = (alu_zero) ? branch_calc : pc_plus_4;
            end
            BRANCH_NE: begin
                branch_taken = !alu_zero;
                PC_next = (alu_zero) ? pc_plus_4 : branch_calc;
            end
            BRANCH_LT: begin
                branch_taken = alu_negative;
                PC_next = (alu_negative) ? branch_calc : pc_plus_4;
            end
            BRANCH_GE: begin
                branch_taken = !alu_negative;
                PC_next = (alu_negative) ? pc_plus_4 : branch_calc;
            end
            default: begin
                branch_taken = 1'b0;
                PC_next = pc_plus_4;
            end
        endcase
    end

endmodule

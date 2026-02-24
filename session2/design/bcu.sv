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
            // Implement your BCU here

            default:       PC_next = pc_plus_4;
        endcase
    end

endmodule

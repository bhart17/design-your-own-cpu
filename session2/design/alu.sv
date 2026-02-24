module alu (
    input  enums_pkg::alu_op_t        alu_op,
    input  logic signed        [31:0] operand_a,
    input  logic signed        [31:0] operand_b,
    output logic signed        [31:0] result,
    output logic                      result_zero,
    output logic                      result_negative
);

    timeunit 1ns; timeprecision 100ps;

    import enums_pkg::*;

    always_comb begin
        case (alu_op)
            // Implement your ALU here

            default:    result = operand_a + operand_b;
        endcase
    end

    // Fix these lines
    assign result_zero     = 1'b0;
    assign result_negative = 1'b0;

endmodule

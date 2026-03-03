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
            ALU_SUB:    result = operand_a - operand_b;
            ALU_SUBU:   result = $unsigned(operand_a) - $unsigned(operand_b);
            ALU_OR:     result = operand_a | operand_b;
            ALU_AND:    result = operand_a & operand_b;
            ALU_XOR:    result = operand_a ^ operand_b;
            ALU_SLT:    result = {31'b0, operand_a < operand_b};
            ALU_SLTU:   result = {31'b0, $unsigned(operand_a) < $unsigned(operand_b)};
            ALU_SLL:    result = operand_a << operand_b[4:0];
            ALU_SRL:    result = operand_a >> operand_b[4:0];
            ALU_SRA:    result = operand_a >>> operand_b[4:0];
            ALU_PASS_B: result = operand_b;
            default:    result = operand_a + operand_b;
        endcase
    end

    assign result_zero     = (result == 32'd0);
    assign result_negative = result[31];

endmodule

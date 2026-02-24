module rom #(
    parameter integer MEM_WIDTH = 12
) (
    // Instruction memory interface
    input  logic [31:0] inst_address,
    input  logic        inst_read_enable,
    output logic [31:0] inst_read_data,

    // Data memory interface
    input  logic [31:0] data_address,
    input  logic        data_read_enable,
    output logic [31:0] data_read_data
);

    timeunit 1ns; timeprecision 100ps;

    logic [31:0] memory[2**(MEM_WIDTH-2)];

    initial begin
        memory = '{default: '0};
        // Write a machine code program here

        memory[0] = 32'h0000_0000;  // NOP
        memory[1] = 32'h0010_0073;  // EBREAK
    end

    assign inst_read_data = (inst_read_enable) ? memory[inst_address[MEM_WIDTH-1:2]] : 32'd0;
    assign data_read_data = (data_read_enable) ? memory[data_address[MEM_WIDTH-1:2]] : 32'd0;

endmodule

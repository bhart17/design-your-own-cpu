module regfile (
    input  logic [ 4:0] rs1_address,
    output logic [31:0] rs1_read_data,

    input  logic [ 4:0] rs2_address,
    output logic [31:0] rs2_read_data,

    input logic [ 4:0] rd_address,
    input logic        rd_write_enable,
    input logic [31:0] rd_write_data,

    input logic clock,
    input logic n_reset
);

    timeunit 1ns; timeprecision 100ps;

    logic [31:0] registers[31:0];

    // Implement your Register File here


endmodule

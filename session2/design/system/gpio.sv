module gpio (
    input  logic [31:0] address,
    input  logic        read_enable,
    input  logic        write_enable,
    output logic [31:0] read_data,
    input  logic [31:0] write_data,

    input logic clock
);

    timeunit 1ns; timeprecision 100ps;

    // No GPIO implementation in this system - wait for next week!

    assign read_data = 32'd0;

endmodule

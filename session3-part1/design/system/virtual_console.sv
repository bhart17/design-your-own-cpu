module virtual_console (
    input  logic        write_enable,
    output logic [31:0] read_data,
    input  logic [31:0] write_data,

    input logic clock
);

    timeunit 1ns; timeprecision 100ps;

    always_ff @(posedge clock) begin
        if (write_enable) $write("%s", write_data[6:0]);
    end

    assign read_data = 32'd0;

endmodule

module gpio (
    input  logic        read_enable,
    input  logic        write_enable,
    output logic [31:0] read_data,
    input  logic [31:0] write_data,

    output logic [7:0] output_register,

    input logic clock,
    input logic n_reset
);

    timeunit 1ns; timeprecision 100ps;

    always_ff @(posedge clock, negedge n_reset) begin
        if (!n_reset) output_register <= 8'd0;
        else if (write_enable) begin
            output_register <= write_data[7:0];
            $display("[%8t] \033[1;32m[GPIO] Output=%8b", $time, output_register);
        end
    end

    assign read_data = (read_enable) ? {24'd0, output_register} : 32'd0;

endmodule

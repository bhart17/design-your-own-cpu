module lfsr (
    output logic [7:0] random,
    input  logic clock,
    input  logic nreset
);

    timeunit 1ns; timeprecision 10ps;

    logic [7:0] shift_register;

    always_ff @(posedge clock, negedge nreset) begin
        // Model your shift register here

    end

endmodule

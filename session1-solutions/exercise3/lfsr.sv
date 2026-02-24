module lfsr (
    output logic [7:0] random,
    input  logic clock,
    input  logic nreset
);

    timeunit 1ns; timeprecision 10ps;

    logic [7:0] shift_register;

    logic next_shift;

    always_ff @(posedge clock, negedge nreset) begin
        // Model your shift register here
        if (!nreset) shift_register <= 8'b00100110;
        else shift_register <= {shift_register[6:0], next_shift};
    end

    assign next_shift = shift_register[4] ^ shift_register[6];

    assign random = shift_register;

endmodule

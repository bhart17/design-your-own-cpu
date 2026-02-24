module inv1 (
    input  logic A,
    output logic Y
);

    timeunit 1ns; timeprecision 100ps;

    // Model the behaviour of the module here

    assign Y = ~A;


endmodule

module full_adder (
    input  logic A,
    input  logic B,
    input  logic Cin,
    output logic Sum,
    output logic Cout
);

    timeunit 1ns; timeprecision 100ps;

    // Model your full adder here

    assign {Cout, Sum} = 2'(A) + 2'(B) + 2'(Cin);

endmodule

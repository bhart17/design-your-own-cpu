module testbench;

    timeunit 1ns; timeprecision 100ps;

    // Inputs
    logic A;
    logic B;

    // Outputs
    logic Y_inv;
    logic Y_and;
    logic Y_or;
    logic Y_xor;

    // Instatiate our modules under test
    inv1 inv1_0 ( .A,     .Y(Y_inv) );

    and2 and2_0 ( .A, .B, .Y(Y_and) );

    or2  or2_0  ( .A, .B, .Y(Y_or)  );

    xor2 xor2_0 ( .A, .B, .Y(Y_xor) );

    // Apply our test inputs
    initial begin
        {A, B} = 2'b00;
        #1 {A, B} = 2'b01;
        #1 {A, B} = 2'b10;
        #1 {A, B} = 2'b11;
        #1 $finish;
    end

endmodule

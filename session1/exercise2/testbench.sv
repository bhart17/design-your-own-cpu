module testbench;

    timeunit 1ns; timeprecision 100ps;

    // Inputs
    logic A;
    logic B;
    logic Cin;

    // Outputs
    logic Sum;
    logic Cout;

    // Device Under Test
    full_adder full_adder0 (
        .A,
        .B,
        .Cin,
        .Sum,
        .Cout
    );

    // Apply test inputs
    initial begin
        for (int unsigned ii = 0; ii < 8; ii++) begin
            {A, B, Cin} = 3'(ii);
            #1;
        end
        $finish;
    end

    // Log to console
    initial begin
        $timeformat(-9, 0, "ns");
        $display("\n# SIMULATED TRUTH TABLE\n");
        $display("#     Input    |   Output   ");
        $display("#  A | B | Cin | Sum | Cout ");
        $display("# ---+---+-----+-----+------");
        $monitor(
            "# ",
            " %b  ", A,
            " %b  ", B,
            "  %b  ", Cin,
            "|",
            "  %b  ", Sum,
            "   %b  ", Cout
        );
    end

endmodule

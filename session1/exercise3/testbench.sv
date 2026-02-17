module testbench;

    timeunit 1ns; timeprecision 10ps;

    // Test I/O
    logic [7:0] random;
    logic       clock;
    logic       nreset;

    // Device Under Test
    lfsr lfsr_0 ( .random, .clock, .nreset );

    // Clock generation
    always begin
        clock = '0;
        #0.25 clock = '1;
        #0.5  clock = '0;
        #0.25;
    end

    // Reset generation
    initial begin
        nreset = '0;
        #0.2 nreset = '1;
    end

    always begin
        $timeformat(-9, 0, "ns");
        #1 $display("[%2t] Shift register value: %d (as binary: %08b)", $time, random, random);
    end

    initial #20 $finish;

endmodule

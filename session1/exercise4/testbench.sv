module testbench;

    timeunit 1ns; timeprecision 10ps;

    // Test I/O
    logic GREEN_LIGHT;
    logic AMBER_LIGHT;
    logic RED_LIGHT;
    logic BUTTON;
    logic clock;
    logic nreset;

    // Instantiate your traffic light controller here


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

    // Apply some test inputs here


endmodule

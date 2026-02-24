module hello_world;

    timeunit 1ns; timeprecision 100ps;

    initial begin
        $timeformat(-9, 0, "ns");
        $display("Hello world!");
        $display("Well done - you just simulated your first SystemVerilog module!");
    end

    // Add your own procedural block here

    always begin
        #2 $display("%3t my custom print", $time);
    end

    always begin
        #3 $display("%3t ECSS is the best", $time);
    end


    initial #20 $finish;

endmodule

module system_tb;

    timeunit 1ns; timeprecision 100ps;

    logic halt;

    logic clock;
    logic n_reset;

    system DUT (
        .halt,
        .clock,
        .n_reset
    );

    initial begin
        n_reset = '0;
        #200 n_reset = '1;
    end

    always begin
        clock = '0;
        #250 clock = '1;
        #500 clock = '0;
        #250;
    end

    initial begin
        $timeformat(-9, 0, "ns");
        $display("\n[%8t] \033[1;32m[TB] Starting simulation\033[0m", $time);
    end

    always begin
        #250 trace();
        #750;
    end

    longint sim_cycles;
    initial begin
        if ($test$plusargs("SIM_CYCLES")) begin
            void'($value$plusargs("SIM_CYCLES=%d", sim_cycles));
        end else begin
            sim_cycles = 100;
        end
        #(sim_cycles * 1000);
        $display("[%8t] \033[1;32m[TB] Simulation finished due to SIM_CYCLES reached\033[0m\n",
                 $time);
        $finish;
    end

    initial begin
        wait (halt);
        #1000;
        trace();
        $display("[%8t] \033[1;32m[TB] Simulation finished due to HALT signal\033[0m\n", $time);
        $finish;
    end

    task trace();
        if ($test$plusargs("TRACE")) begin
            $display("[%8t] \033[1;32m[TRACE] PC=0x%h Inst=0x%h\033[0m", $time, DUT.core0.PC, DUT.core0.instruction);
        end
    endtask

endmodule

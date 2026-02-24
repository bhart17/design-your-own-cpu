`include "riscv_opcodes_pkg.svh"
`include "enums_pkg.svh"
`include "decoder_pkg.svh"
`include "control_pkg.svh"

module system (
    output logic halt,
    input  logic clock,
    input  logic n_reset
);

    timeunit 1ns; timeprecision 100ps;

    localparam integer NUM_PERIPHERALS = 4;

    import enums_pkg::*;

    // Instruction memory interface
    logic [31:0] inst_address;
    logic        inst_read_enable;
    logic [31:0] inst_read_data;

    // Data memory interface
    logic [31:0] data_address;
    mem_size_t   data_size;
    logic        data_write_enable;
    logic        data_read_enable;
    logic [31:0] data_write_data;
    logic [31:0] data_read_data;

    logic [31:0] data_read_datas   [NUM_PERIPHERALS];
    logic        data_read_enables [NUM_PERIPHERALS];
    logic        data_write_enables[NUM_PERIPHERALS];

    core #(
        .RESET_VECTOR(32'h0000_0000)
    ) core0 (
        .halt(halt),

        .inst_address    (inst_address),
        .inst_read_enable(inst_read_enable),
        .inst_read_data  (inst_read_data),

        .data_address     (data_address),
        .data_size        (data_size),
        .data_write_enable(data_write_enable),
        .data_read_enable (data_read_enable),
        .data_write_data  (data_write_data),
        .data_read_data   (data_read_data),

        .clock  (clock),
        .n_reset(n_reset)
    );

    dma_controller #(
        .NUM_PERIPHERALS(NUM_PERIPHERALS)
    ) dma_controller0 (
        .address           (data_address),
        .size              (data_size),
        .read_enable       (data_read_enable),
        .write_enable      (data_write_enable),
        .read_data         (data_read_data),
        .read_datas        (data_read_datas),
        .read_enables      (data_read_enables),
        .write_enables     (data_write_enables)
    );

    rom #(
        .MEM_WIDTH(12)
    ) rom0 (
        .inst_address    (inst_address),
        .inst_read_enable(inst_read_enable),
        .inst_read_data  (inst_read_data),
        .data_address    (data_address),
        .data_read_enable(data_read_enables[0]),
        .data_read_data  (data_read_datas[0])
    );

    ram #(
        .MEM_WIDTH(12)
    ) ram0 (
        .address     (data_address),
        .size        (data_size),
        .read_enable (data_read_enables[1]),
        .write_enable(data_write_enables[1]),
        .read_data   (data_read_datas[1]),
        .write_data  (data_write_data),
        .clock       (clock)
    );

    gpio gpio0 (
        .address     (data_address),
        .read_enable (data_read_enables[2]),
        .write_enable(data_write_enables[2]),
        .read_data   (data_read_datas[2]),
        .write_data  (data_write_data),
        .clock       (clock)
    );

    virtual_console virtual_console0 (
        .write_enable(data_write_enables[3]),
        .read_data   (data_read_datas[3]),
        .write_data  (data_write_data),
        .clock       (clock)
    );

endmodule

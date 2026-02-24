module ram #(
    parameter integer MEM_WIDTH = 12
) (
    input  logic [31:0]          address,
    input  enums_pkg::mem_size_t size,
    input  logic                 read_enable,
    input  logic                 write_enable,
    output logic [31:0]          read_data,
    input  logic [31:0]          write_data,

    input logic clock
);

    timeunit 1ns; timeprecision 100ps;

    import enums_pkg::*;

    logic [3:0][7:0] memory[2**(MEM_WIDTH-2)];

    logic [31:0] write_data_aligned;
    logic [3:0] byte_mask;

    always_comb begin
        write_data_aligned = write_data << (address[1:0] << 3);
        case (size)
            MEM_BYTE, MEM_BYTEU: byte_mask = 4'b0001 << (address[1:0] << 2'd3);
            MEM_HALF, MEM_HALFU: byte_mask = 4'b0011 << (address[1:0] << 2'd3);
            default:             byte_mask = 4'b1111 << (address[1:0] << 2'd3);
        endcase
    end

    always_ff @(posedge clock) begin
        if (write_enable) begin
            if (byte_mask[0]) memory[address[MEM_WIDTH-1:2]][0] <= write_data_aligned[ 7: 0];
            if (byte_mask[1]) memory[address[MEM_WIDTH-1:2]][1] <= write_data_aligned[15: 8];
            if (byte_mask[2]) memory[address[MEM_WIDTH-1:2]][2] <= write_data_aligned[23:16];
            if (byte_mask[3]) memory[address[MEM_WIDTH-1:2]][3] <= write_data_aligned[31:24];
        end
    end

    assign read_data = (read_enable) ? memory[address[MEM_WIDTH-1:2]] : 32'd0;

endmodule

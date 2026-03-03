module dma_controller #(
    parameter integer NUM_PERIPHERALS = 4
) (
    // Signals to core.
    input  logic [31:0]          address,
    input  enums_pkg::mem_size_t size,
    input  logic                 read_enable,
    input  logic                 write_enable,
    output logic [31:0]          read_data,

    // Signals to perhpherals.
    input  logic [31:0] read_datas   [NUM_PERIPHERALS],
    output logic        read_enables [NUM_PERIPHERALS],
    output logic        write_enables[NUM_PERIPHERALS]
);

    timeunit 1ns; timeprecision 100ps;

    import enums_pkg::*;

    function automatic [31:0] align(mem_size_t size, logic[1:0] offset, logic [31:0] data);
        logic [31:0] data_aligned;
        data_aligned = data >> (5'(offset) << 5'd3);
        case (size)
            MEM_BYTE:  return {{24{data_aligned[7]}}, data_aligned[7:0]};
            MEM_BYTEU: return {24'd0, data_aligned[7:0]};
            MEM_HALF:  return {{16{data_aligned[15]}}, data_aligned[15:0]};
            MEM_HALFU: return {16'd0, data_aligned[15:0]};
            default:   return data_aligned;
        endcase
    endfunction

    logic [($clog2(NUM_PERIPHERALS)-1):0] selected_peripheral;

    assign selected_peripheral = address[31:(32-$clog2(NUM_PERIPHERALS))];

    assign read_data = align(size, address[1:0], read_datas[selected_peripheral]);

    always_comb begin
        read_enables = '{default: '0};
        write_enables = '{default: '0};
        read_enables[selected_peripheral] = read_enable;
        write_enables[selected_peripheral] = write_enable;
    end

endmodule

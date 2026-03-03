module core #(
    parameter logic [31:0] RESET_VECTOR = 32'h0000_0000
) (
    output logic halt,

    // Instruction memory interface
    output logic [31:0] inst_address,
    output logic        inst_read_enable,
    input  logic [31:0] inst_read_data,

    // Data memory interface
    output logic                 [31:0] data_address,
    output enums_pkg::mem_size_t        data_size,
    output logic                        data_write_enable,
    output logic                        data_read_enable,
    output logic                 [31:0] data_write_data,
    input  logic                 [31:0] data_read_data,

    input logic clock,
    input logic n_reset
);

    timeunit 1ns; timeprecision 100ps;

    import enums_pkg::*;
    import decoder_pkg::*;
    import control_pkg::*;

    // Pipeline registers
    logic       [31:0] PC_fetch;
    logic       [31:0] PC_exe;
    logic       [31:0] instruction_exe;
    logic       [31:0] rs1_read_data_exe;
    logic       [31:0] rs2_read_data_exe;
    logic       [31:0] immediate_exe;

    // Fetch signals
    logic       [31:0] PC_next;
    logic       [31:0] instruction;
    logic       [ 4:0] rs1_address;
    logic       [31:0] rs1_read_data;
    logic       [ 4:0] rs2_address;
    logic       [31:0] rs2_read_data;
    logic       [ 4:0] rd_address;
    logic              rd_write_enable;
    logic       [31:0] rd_write_data;
    logic       [31:0] immediate;

    // Execute signals
    alu_op_t           alu_op;
    logic       [31:0] operand_a;
    logic       [31:0] operand_b;
    logic       [31:0] alu_result;
    logic              result_zero;
    logic              result_negative;
    branch_op_t        branch_op;
    logic              branch_taken;


    // --- Fetch ---

    assign inst_address     = PC_fetch;
    assign inst_read_enable = 1'b1;

    always_ff @(posedge clock, negedge n_reset) begin
        if (!n_reset) PC_fetch <= RESET_VECTOR;
        else PC_fetch <= PC_next;
    end

    // Fetch: Decode

    assign instruction = inst_read_data;

    assign rs1_address = get_rs1(instruction);
    assign rs2_address = get_rs2(instruction);

    regfile regfile0 (
        .rs1_address    (rs1_address),
        .rs1_read_data  (rs1_read_data),
        .rs2_address    (rs2_address),
        .rs2_read_data  (rs2_read_data),
        .rd_address     (rd_address),
        .rd_write_enable(rd_write_enable),
        .rd_write_data  (rd_write_data),
        .clock          (clock),
        .n_reset        (n_reset)
    );

    assign immediate = get_immediate(instruction);

    assign halt = get_halt(instruction);

    always_ff @(posedge clock, negedge n_reset) begin
        if (!n_reset) begin
            PC_exe <= '0;
            instruction_exe <= 32'h13;
            rs1_read_data_exe <= '0;
            rs2_read_data_exe <= '0;
            immediate_exe <= '0;
        end else begin
            // Add your pipeline registers here

        end
    end


    // --- Execute ---

    assign alu_op = get_alu_op(instruction_exe);

    assign operand_a = (select_pc_alu(instruction_exe)) ? PC_exe : rs1_read_data_exe;
    assign operand_b = (select_immediate_alu(instruction_exe)) ? immediate_exe : rs2_read_data_exe;

    alu alu0 (
        .alu_op         (alu_op),
        .operand_a      (operand_a),
        .operand_b      (operand_b),
        .result         (alu_result),
        .result_zero    (result_zero),
        .result_negative(result_negative)
    );

    assign branch_op = get_branch_op(instruction_exe);

    bcu bcu0 (
        .branch_op   (branch_op),
        .PC_fetch    (PC_fetch),
        .PC_exe      (PC_exe),
        .immediate   (immediate_exe),
        .alu_zero    (result_zero),
        .alu_negative(result_negative),
        .PC_next     (PC_next),
        .branch_taken(branch_taken)
    );

    // Execute: Memory

    assign data_address      = alu_result;
    assign data_size         = get_memory_size(instruction_exe);
    assign data_read_enable  = get_memory_read_enable(instruction_exe);
    assign data_write_enable = get_memory_write_enable(instruction_exe);
    assign data_write_data   = rs2_read_data_exe;

    // Execute: Writeback

    assign rd_address      = get_rd(instruction_exe);
    assign rd_write_enable = get_rd_write_enable(instruction_exe);
    assign rd_write_data   = select_memory_wb(instruction_exe) ? data_read_data : alu_result;

endmodule

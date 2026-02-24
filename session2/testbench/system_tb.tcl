simvision {

    window new WaveWindow -name "Design Your Own CPU Waves"
    window geometry "Design Your Own CPU Waves" 1010x500+25+50
    waveform using "Design Your Own CPU Waves"

    waveform add -signals system_tb.n_reset
    waveform add -signals system_tb.clock
    waveform add -signals system_tb.halt
    waveform add -cdivider divider
    waveform add -signals system_tb.DUT.core0.PC
    waveform add -signals system_tb.DUT.core0.instruction
    waveform add -cdivider divider
    waveform add -signals system_tb.DUT.core0.rs1_address
    waveform add -signals system_tb.DUT.core0.rs1_read_data
    waveform add -signals system_tb.DUT.core0.rs2_address
    waveform add -signals system_tb.DUT.core0.rs2_read_data
    waveform add -signals system_tb.DUT.core0.immediate
    waveform add -cdivider divider
    waveform add -signals system_tb.DUT.core0.alu_op
    waveform add -signals system_tb.DUT.core0.operand_a
    waveform add -signals system_tb.DUT.core0.operand_b
    waveform add -signals system_tb.DUT.core0.alu_result
    waveform add -signals system_tb.DUT.core0.result_zero
    waveform add -signals system_tb.DUT.core0.result_negative
    waveform add -cdivider divider
    waveform add -signals system_tb.DUT.core0.branch_op
    waveform add -signals system_tb.DUT.core0.PC_next
    waveform add -cdivider divider
    waveform add -signals system_tb.DUT.core0.data_address
    waveform add -signals system_tb.DUT.core0.data_size
    waveform add -signals system_tb.DUT.core0.data_read_enable
    waveform add -signals system_tb.DUT.core0.data_read_data
    waveform add -signals system_tb.DUT.core0.data_write_enable
    waveform add -signals system_tb.DUT.core0.data_write_data
    waveform add -cdivider divider
    waveform add -signals system_tb.DUT.core0.rd_address
    waveform add -signals system_tb.DUT.core0.rd_write_data

}

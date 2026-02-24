simvision {

    window new WaveWindow -name "Waves"
    window geometry "Waves" 1010x500+25+50
    waveform using "Waves"

    waveform add -signals testbench.A
    waveform add -signals testbench.B
    waveform add -signals testbench.Y_inv
    waveform add -signals testbench.Y_and
    waveform add -signals testbench.Y_or
    waveform add -signals testbench.Y_xor

}

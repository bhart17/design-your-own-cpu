simvision {

    window new WaveWindow -name "Waves"
    window geometry "Waves" 1010x500+25+50
    waveform using "Waves"

    waveform add -signals testbench.nreset
    waveform add -signals testbench.clock
    waveform add -signals testbench.random

}

module traffic_light_controller (
    output logic GREEN_LIGHT,
    output logic AMBER_LIGHT,
    output logic RED_LIGHT,
    input  logic BUTTON,
    input  logic clock,
    input  logic nreset
);

    timeunit 1ns; timeprecision 10ps;

    // Model your traffic light controller ASM here
    typedef enum logic [1:0] {
        GREEN,
        AMBER,
        RED,
        RED_AMBER
    } state_t;

    state_t state;

    always_ff @(posedge clock, negedge nreset) begin
        if (!nreset) state <= GREEN;
        else begin
            case (state)
                GREEN: if (BUTTON) state <= AMBER;
                AMBER: state <= RED;
                RED: state <= RED_AMBER;
                RED_AMBER: state <= GREEN;
            endcase
        end
    end

    always_comb begin
        GREEN_LIGHT = '0;
        AMBER_LIGHT = '0;
        RED_LIGHT = '0;
        case (state)
            GREEN: GREEN_LIGHT = '1;
            AMBER: AMBER_LIGHT = '1;
            RED:   RED_LIGHT   = '1;
            RED_AMBER: begin
                AMBER_LIGHT = '1;
                RED_LIGHT   = '1;
            end
        endcase
    end

endmodule

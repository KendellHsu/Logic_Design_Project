module ScoreCounter (
<<<<<<< HEAD
    input wire clk,           // Clock signal
    input wire reset,         // Reset signal
    input wire [7:0] combo,   // Combo value
    input wire [1:0] Inp,     // Input state value
    output reg [15:0] score   // Score output
);

    // Define the score values for each state
    parameter SCORE_00 = 16'd0;
=======
    input wire clk,           // �����H��
    input wire reset,         // ���m�H��
    input wire [1:0] Inp,     // ��J���A��
    output reg [15:0] score   // ���ƿ�X
);

    // �w�q�C�Ӫ��A������
>>>>>>> 8e158f4a3bad87d8e74ea75775bb9fc9480b2457
    parameter SCORE_01 = 16'd32;
    parameter SCORE_10 = 16'd32;
    parameter SCORE_11 = 16'd256;
    parameter MAX_SCORE = 16'd65535;

    // Declare the variables outside the always block
    reg [15:0] add_score;
    reg [4:0] multiplier;

    // Initialize score to 0
    initial begin
        score <= 16'd0;
    end

    // Calculate the multiplier based on the combo value
    function [4:0] get_multiplier(input [7:0] combo);
        begin
            if (combo >= 1 && combo <= 16)
                get_multiplier = 5'd2;
            else if (combo >= 17 && combo <= 32)
                get_multiplier = 5'd3;
            else if (combo >= 33 && combo <= 48)
                get_multiplier = 5'd4;
            else if (combo >= 49 && combo <= 64)
                get_multiplier = 5'd5;
            else if (combo >= 65 && combo <= 80)
                get_multiplier = 5'd6;
            else if (combo >= 81 && combo <= 96)
                get_multiplier = 5'd7;
            else if (combo >= 97 && combo <= 112)
                get_multiplier = 5'd8;
            else if (combo >= 113 && combo <= 128)
                get_multiplier = 5'd9;
            else if (combo >= 129 && combo <= 144)
                get_multiplier = 5'd10;
            else if (combo >= 145 && combo <= 160)
                get_multiplier = 5'd11;
            else if (combo >= 161 && combo <= 176)
                get_multiplier = 5'd12;
            else if (combo >= 177 && combo <= 192)
                get_multiplier = 5'd13;
            else if (combo >= 193 && combo <= 208)
                get_multiplier = 5'd14;
            else if (combo >= 209 && combo <= 224)
                get_multiplier = 5'd15;
            else if (combo >= 225 && combo <= 240)
                get_multiplier = 5'd16;
            else if (combo >= 241 && combo <= 256)
                get_multiplier = 5'd17;
            else
                get_multiplier = 5'd1; // Default multiplier is 1 if combo is 0 or invalid
        end
    endfunction

    // Main logic to update score based on state and combo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
<<<<<<< HEAD
            score <= 16'd0;  // When reset signal is high, reset the score to 0
        end 
        else begin
            multiplier = get_multiplier(combo);

            case (Inp)
                2'b00: add_score = SCORE_00;
                2'b01: add_score = SCORE_01;
                2'b10: add_score = SCORE_10;
                2'b11: add_score = SCORE_11;
                default: add_score = 16'd0;
=======
            score <= 16'd0;  // ��reset�H�������ɡA�����k�s
        end else begin
            case (Inp) 
                2'b01: score <= (score + SCORE_01 <= MAX_SCORE) ? score + SCORE_01 : MAX_SCORE;
                2'b10: score <= (score + SCORE_10 <= MAX_SCORE) ? score + SCORE_10 : MAX_SCORE;
                2'b11: score <= (score + SCORE_11 <= MAX_SCORE) ? score + SCORE_11 : MAX_SCORE;
                default: score <= score;  // ��L���p�U���ƫO������
>>>>>>> 8e158f4a3bad87d8e74ea75775bb9fc9480b2457
            endcase

            add_score = add_score * multiplier;
            score <= (score + add_score <= MAX_SCORE) ? score + add_score : MAX_SCORE;
        end
    end

endmodule
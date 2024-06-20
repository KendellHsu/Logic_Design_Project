module ScoreCounter (
    input wire clk,           // �����H��
    input wire reset,         // ���m�H��
    input wire [1:0] Inp,     // ��J���A��
    output reg [15:0] score   // ���ƿ�X
);

    // �w�q�C�Ӫ��A������
    parameter SCORE_01 = 16'd32;
    parameter SCORE_10 = 16'd256;
    parameter SCORE_11 = 16'd512;
    parameter MAX_SCORE = 16'd65535;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            score <= 16'd0;  // ��reset�H�������ɡA�����k�s
        end else begin
            case (Inp) 
                2'b01: score <= (score + SCORE_01 <= MAX_SCORE) ? score + SCORE_01 : MAX_SCORE;
                2'b10: score <= (score + SCORE_10 <= MAX_SCORE) ? score + SCORE_10 : MAX_SCORE;
                2'b11: score <= (score + SCORE_11 <= MAX_SCORE) ? score + SCORE_11 : MAX_SCORE;
                default: score <= score;  // ��L���p�U���ƫO������
            endcase
        end
    end

endmodule
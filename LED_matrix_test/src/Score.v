module ScoreCounter (
    input wire clk,           // 時鐘信號
    input wire reset,         // 重置信號
    input wire [1:0] Inp,     // 輸入狀態值
    output reg [15:0] score   // 分數輸出
);

    // 定義每個狀態的分數
    parameter SCORE_01 = 16'd32;
    parameter SCORE_10 = 16'd256;
    parameter SCORE_11 = 16'd512;
    parameter MAX_SCORE = 16'd65535;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            score <= 16'd0;  // 當reset信號為高時，分數歸零
        end else begin
            case (Inp)
                2'b01: score <= (score + SCORE_01 <= MAX_SCORE) ? score + SCORE_01 : MAX_SCORE;
                2'b10: score <= (score + SCORE_10 <= MAX_SCORE) ? score + SCORE_10 : MAX_SCORE;
                2'b11: score <= (score + SCORE_11 <= MAX_SCORE) ? score + SCORE_11 : MAX_SCORE;
                default: score <= score;  // 其他情況下分數保持不變
            endcase
        end
    end

endmodule

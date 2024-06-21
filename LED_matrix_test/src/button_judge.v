module button_judge (
    input clk,
    input rst,
    input red_button,           // red button pressed
    input blue_button,
    input [2:0] offset,         // offset from shift.v
    input node_R,
    input node_B,
    output reg delete_note,
    output reg [1:0] score      // output for score.v
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            score <= 2'b00;
            delete_note <= 1'b0;
        end else begin
            // Reset delete signals at the start of each cycle
            delete_red_node <= 1'b0;
            delete_blue_node <= 1'b0;

            if (red_button) begin
                if (node_R) begin
                    delete_note <= 1'b1;
                    case (offset)
                        3'd2, 3'd3, 3'd4: score <= 2'b11;  // perfect
                        3'd5: score <= 2'b10;              // late
                        3'd1: score <= 2'b01;              // early
                        default: score <= 2'b00;           // none
                    endcase
                end
            end

            if (blue_button) begin
                if (node_B) begin
                    delete_note <= 1'b1;
                    case (offset)
                        3'd2, 3'd3, 3'd4: score <= 2'b11;  // perfect
                        3'd5: score <= 2'b10;              // late
                        3'd1: score <= 2'b01;              // early
                        default: score <= 2'b00;           // none
                    endcase
                end
            end
        end
    end
endmodule

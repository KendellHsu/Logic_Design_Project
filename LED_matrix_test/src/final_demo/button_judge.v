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

    reg red_button_prev;
    reg blue_button_prev;

    wire red_button_edge = red_button & ~red_button_prev;
    wire blue_button_edge = blue_button & ~blue_button_prev;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            score <= 2'b00;
            delete_note <= 1'b0;
            red_button_prev <= 1'b0;
            blue_button_prev <= 1'b0;

        end else begin
            // Update previous button states
            red_button_prev <= red_button;
            blue_button_prev <= blue_button;
            
            // Reset delete signals at the start of each cycle
            delete_note <= 1'b0;
            
            if (red_button_edge) begin
                if (node_R) begin
                    delete_note <= 1'b1;
                    case (offset)
                        3'd2, 3'd3, 3'd4: score <= 2'b11;  // perfect
                        3'd5, 3'd6: score <= 2'b10;        // late
                        3'd1, 3'd0: score <= 2'b01;        // early
                        default: score <= 2'b00;           // none
                    endcase
                end
            end else if (blue_button_edge) begin
                if (node_B) begin
                    delete_note <= 1'b1;
                    case (offset)
                        3'd2, 3'd3, 3'd4: score <= 2'b11;  // perfect
                        3'd5, 3'd6: score <= 2'b10;        // late
                        3'd1, 3'd0: score <= 2'b01;        // early
                        default: score <= 2'b00;           // none
                    endcase
                end
            end else begin
                score <= 1'd0;
                delete_note <= 1'd0;
            end
        end
    end
endmodule

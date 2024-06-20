module red_button_judge (
    input clk,
    input rst,
    input button,             // red button pressed
    input [3:0] offset,       // offset from shift.v
    input [3:0] node_R,
    output reg [1:0] score    // output for score.v
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            score <= 2'b00;
        end else if (button) begin
            if(node_R[1]) begin
                case (offset)
                    4'd2, 4'd3, 4'd4: score <= 2'b11;        // perfect
                    4'd5, 4'd6: score <= 2'b10;              // late
                    4'd0, 4'd1: score <= 2'b01;              // early
                    default: score <= 2'b00;                 // none
                endcase
            end
        end 
    end

endmodule
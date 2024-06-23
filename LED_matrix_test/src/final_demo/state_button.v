module state_button (
    input            clk,
    input            rst,
    input            finish,
    input            red_button,
    input            blue_button,
    input            yellow_button,
    output reg [1:0] song_confirm,
    output reg [1:0] song_select,  
    output reg [1:0] state
);
    localparam START = 2'd0, MENU = 2'd1, PLAY = 2'd2, FINISH = 2'd3;
    parameter JITTER = 5000;
    reg [1:0]  CS, NS;
    wire [2:0]  signal;
    reg [15:0] cnt_button_R;
    reg [15:0] cnt_button_B;
    reg [15:0] cnt_button_Y;
    reg [1:0] red_r;
    reg [1:0] blue_r;
    reg [1:0] yellow_r;
    reg button_enable;

    assign signal[0] = ((cnt_button_R == JITTER - 1) && (red_button == 1'b1)) ? 1'b1 : 1'b0;
    assign signal[1] = ((cnt_button_B == JITTER - 1) && (blue_button == 1'b1)) ? 1'b1 : 1'b0;
    assign signal[2] = ((cnt_button_Y == JITTER - 1) && (yellow_button == 1'b1)) ? 1'b1 : 1'b0;

    always @(posedge clk or posedge rst) begin
        if(rst) begin       
                red_r         <= 2'd0;
                blue_r        <= 2'd0;
                yellow_r      <= 2'd0;
        end

        else begin
            red_r    <= {red_r[0]   , red_button};
            blue_r   <= {blue_r[0]  , blue_button};
            yellow_r <= {yellow_r[0], yellow_button};
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin 
            cnt_button_R  <= 16'd0;
            cnt_button_B  <= 16'd0;
            cnt_button_Y  <= 16'd0;
        end
        else begin
            if((red_r[0]^red_r[1])==1'b1) begin
            cnt_button_R <= 0;
            end
            else if (cnt_button_R == JITTER) begin
                cnt_button_R <= cnt_button_R;
            end 
            else begin
                cnt_button_R <= cnt_button_R + 1;
            end

            if((blue_r[0]^blue_r[1])==1'b1) begin
                cnt_button_B <= 0;
            end
            else if (cnt_button_B == JITTER) begin
                cnt_button_B <= cnt_button_B;
            end 
            else begin
                cnt_button_B <= cnt_button_B + 1;
            end

            if((yellow_r[0]^yellow_r[1])==1'b1) begin
                cnt_button_Y <= 0;
            end 
            else if (cnt_button_Y == JITTER) begin
                cnt_button_Y <= cnt_button_Y;
            end
            else begin
                cnt_button_Y <= cnt_button_Y + 1;
            end
        end 
        
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin 
            CS <= START;
            state <= START;
        end

        else begin
            CS <= NS;
            state <= NS;
        end
    end

    always @(*) begin
        case(CS)

        START:  NS = (signal[0] || signal[1] || signal[2]) ? MENU : START;

        MENU:   NS = (signal[2] && song_select != 2'd0)   ? PLAY : MENU;

        PLAY:   NS = (finish)                              ? FINISH : PLAY;

        FINISH: NS = (signal[2])                           ? MENU : FINISH;

        endcase
    end

    always @(posedge clk or posedge rst) begin
        if(rst) song_select = 1'd1;
        else begin
            if(signal == 3'd1)                        song_select <= song_select - 2'd1;
            else if(signal == 3'd2)                   song_select <= song_select + 2'd1;
            else                                      song_select <= song_select;
        end
    end

    always @(*) begin
        song_confirm =(signal == 3'd4) ? song_select : 2'd0;
    end

    
endmodule
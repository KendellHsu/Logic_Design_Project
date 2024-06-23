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
    reg [1:0] CS, NS;
    reg [2:0] last_button;
    reg [2:0] signal;
    reg [15:0] cnt_button;
    reg button_enable;



    always @(posedge clk or posedge rst) begin
        if(rst) begin       
                signal      <= 3'd0;
                cnt_buttom  <= 16'd0;
                last_button <= 3'd0;
        end

        else begin
            
            if(cnt_buttom == 16'd24999) begin
                cnt_buttom    <= 16'd0;
                button_enable <= 1'd1;
                last_button   <= {yellow_button, blue_button, red_button};
            end
            else begin
                cnt_buttom    <= cnt_buttom + 16'd1;
                button_enable <= 1'd0;
                last_button   <= last_button;
            end

            if(red_button == 1'd1 && button_enable  && last_button[0] == 1'd0) signal[0] <= 1'd1;
            else                                                               signal[0] <= 1'd0;

            if(blue_button == 1'd1 && button_enable)                           signal[1] <= 1'd1;
            else                                                               signal[1] <= 1'd0;

            if(yellow_button == 1'd1 && button_enable)                         signal[2] <= 1'd1;
            else                                                               signal[2] <= 1'd0;

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
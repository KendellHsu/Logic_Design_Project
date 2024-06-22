module state_button (
    input            clk,
    input            rst,
    input            finish,
    input            red_button,
    input            blue_button,
    input            yellow_button,
    output reg [1:0] song_confirm,   
    output reg [1:0] state
);
    localparam START = 2'd0, MENU = 2'd1, PLAY = 2'd2, FINISH = 2'd3;
    reg [1:0] CS, NS;
    reg [2:0] last_button;
    reg [1:0] song_select;
    reg [2:0] signal;


    always @(posedge clk or posedge rst) begin
        if(rst) last_button <= 3'd0;
        else    begin
            if(red_button    == 1'd1)  signal[0] = 1'd0;
            if(blue_button   == 1'd1)  signal[1] = 1'd0;
            if(yellow_button == 1'd1)  signal[2] = 1'd0; 
            last_button <= {yellow_button, blue_button, red_button};
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst)                                                  signal    <= 3'd0;
        if(red_button == 1'd1 && last_button[0] == 1'd0)         signal[0] <= 1'd1;
        else if (red_button == 1'd0 && last_button[0] == 1'd0)   signal[0] <= 1'd0;
        else                                                     signal[0] <= 1'd0;
        if(blue_button == 1'd1 && last_button[1] == 1'd0)        signal[1] <= 1'd1;
        else if(blue_button == 1'd0 && last_button[1] == 1'd0)   signal[1] <= 1'd0;
        else                                                     signal[1] <= 1'd0;
        if(yellow_button == 1'd1 && last_button[2] == 1'd0)      signal[2] <= 1'd1;
        else if(yellow_button == 1'd0 && last_button[2] == 1'd0) signal[2] <= 1'd0;
        else                                                     signal[2] <= 1'd0;
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

        START:  NS = (signal[0] || signal[1] || signal[2]) ? PLAY : MENU;

        MENU:   NS = (signal[2] && song_select != 2'd0)   ? PLAY : MENU;

        PLAY:   NS = (finish)                              ? FINISH : PLAY;

        FINISH: NS = (signal[2])                           ? MENU : FINISH;

        endcase
    end

    always @(*) begin
        if(rst) song_select = 1'd0;

        else if(signal == 3'd1 && song_select == 2'd1) song_select = 2'd3;
        else if(signal == 3'd1)                        song_select = song_select - 2'd1;
        else if(signal == 3'd2 && song_select == 2'd3) song_select = 2'd1;
        else if(signal == 3'd2)                        song_select = song_select + 2'd1;
        else                                           song_select = song_select;

    end

    always @(*) begin
        song_confirm =(signal == 3'd4) ? song_select : 2'd0;
    end

    always @(posedge clk) begin
        if(CS == START) begin
            last_button <= 3'd0;
            signal      <= 3'd0;
        end
    end

    
endmodule
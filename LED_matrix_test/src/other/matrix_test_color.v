module matrix (
    input clk,
    input rst,                //positive edge
    output reg A, 
    output reg B,
    output reg C,
    output reg D,
    output reg  R0,
    output reg  G0,
    output reg  B0,
    output reg  R1,
    output reg  G1,
    output reg  B1,
    output reg OE,
    output reg LAT
);


reg [1:0] CS, NS;
reg [6:0] cnt;    // column count
reg [3:0] row;    // row count


parameter IDLE = 2'd0, GET = 2'd1, TRANSMIT = 2'd2;

    //FSM
    always @(posedge clk or posedge rst) begin
        if(rst) CS <= IDLE;

        else       CS <= NS;
    end

    always @(*) begin
        case(CS)

            IDLE: NS = GET;

            GET: NS =(cnt == 7'd64)? TRANSMIT : GET;    //count 64 column

            TRANSMIT: NS = IDLE;

            default: NS = IDLE;
        endcase
    end

//reg 

    //column count
    always @(posedge clk or posedge rst) begin
        if(rst)               cnt <= 7'd0;

        else if(cnt == 7'd64) cnt <= 7'd0;

        else if(NS == GET)    cnt <= cnt + 7'd1;
        else                  cnt <= cnt;
    end


    //row count
    always @(posedge clk or posedge rst) begin
        if(rst) row <= 4'd0;

        else if(CS == TRANSMIT) row <= row + 4'd1;
    end

//output

    //row output
    always @(*) begin
        {D, C, B, A} = row;
    end
    
    //RGB output
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            R0 <= 1'd0;
            G0 <= 1'd0;
            B0 <= 1'd0;
            R1 <= 1'd0;
            G1 <= 1'd0;
            B1 <= 1'd0;
        end

        else if(cnt == 7'd1) begin    //multiple of 16
            R0 <= 1'd1;
            R1 <= 1'd1;
        end

        else if(cnt == 7'd3) begin                   //multiple of 8
            G0 <= 1'd1;
            G1 <= 1'd1;
        end
        else if(cnt == 7'd5) begin                   //multiple of 8
            B0 <= 1'd1;
            B1 <= 1'd1;
        end
        else if(cnt == 7'd7) begin                                                 //multiple of 2
            R0 <= 1'd1;
            G0 <= 1'd1;
            B0 <= 1'd0;
        end
        else if(cnt == 7'd9) begin                                                 //multiple of 2
            R0 <= 1'd1;
            G0 <= 1'd0;
            B0 <= 1'd1;
        end
        else if(cnt == 7'd11) begin                                                 //multiple of 2
            R0 <= 1'd0;
            G0 <= 1'd1;
            B0 <= 1'd1;
        end
        else if(cnt == 7'd13) begin                                                 //multiple of 2
            R0 <= 1'd1;
            G0 <= 1'd1;
            B0 <= 1'd1;
        end
        else if(cnt[0] == 0) begin                                                 //multiple of 2
            R0 <= 1'd0;
            G0 <= 1'd0;
            B0 <= 1'd0;
            R1 <= 1'd0;
            G1 <= 1'd0;
            B1 <= 1'd0;
        end
        else begin
            R0 <= 1'd0;
            G0 <= 1'd0;
            B0 <= 1'd0;
            R1 <= 1'd0;
            G1 <= 1'd0;
            B1 <= 1'd0;
        end
    end

    //OE, LAT output
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            OE  <= 1'd0;
            LAT <= 1'd0;
        end

        else begin
            if(NS == GET) begin
                OE  <= 1'd1;
                LAT <= 1'd0;
            end
            else if(NS == TRANSMIT) begin
                OE  <= 1'd0;
                LAT <= 1'd1;
            end
            else if(NS == IDLE) begin
                OE  <= 1'd0;
                LAT <= 1'd0; 
            end
        end
    end

    endmodule

/*
---------------------------------------------------------------------------------------------------------------
LED matrix can light two rows of pixels per input, and it needs to input 64 pixels of RGB data to light one row.
Therefore, you need to input 128 RGB data in a cycle.
Before entering the data into the LED, OE needs to be pulled up to avoid mistakes.
After all the data is done, pull up LAT to light up the LED.
----------------------------------------------------------------------------------------------------------------
Three states control the LED matrix performance:
IDLE: Initial state.
GET: Retrieve the RGB data 64 times, and OE is pulled up in this state.
TRANSMIT: Perform the LED operation, and LAT is pulled up in this state. Also, the OE signal needs to be pulled down,or the LED matrix won't perform.
*/

module matrix (
    input clk,
    input rst,                //positive edge
    input [1:0] state,
    input [6143:0] menuMap,
    input [191:0] scoreMap0,
    input [191:0] scoreMap1,
    input [191:0] scoreMap2,
    input [191:0] scoreMap3,
    input [191:0] scoreMap4,
    input [191:0] scoreMap5,
    input [191:0] scoreMap6,
    input [191:0] scoreMap7,
    input [191:0] scoreMap8,
    input [191:0] scoreMap9,
    input [191:0] notesMap0,
    input [191:0] notesMap1,
    input [191:0] notesMap2,
    input [191:0] notesMap3,
    input [191:0] notesMap4,
    input [191:0] notesMap5,
    input [191:0] notesMap6,
    output reg A, 
    output reg B,
    output reg C,
    output reg D,
    output reg R0,
    output reg G0,
    output reg B0,
    output reg R1,
    output reg G1,
    output reg B1,
    output reg OE,
    output reg LAT
);


reg [1:0] CS, NS;
reg [6:0] col;    // column count
reg [3:0] row;    // row count

localparam START = 2'd0, MENU = 2'd1, PLAY = 2'd2, FINISH = 2'd3;     // game   control
localparam IDLE = 2'd0, DELAY = 2'd1, GET = 2'd2, TRANSMIT = 2'd3;    // matrix perform

    //FSM
    always @(posedge clk or posedge rst) begin
        if(rst) CS <= IDLE;

        else       CS <= NS;
    end

    always @(*) begin
        case(CS)

            IDLE: NS = DELAY;

            DELAY: NS = GET;

            GET: NS =(col == 7'd64)? TRANSMIT : GET;    //count 64 column

            TRANSMIT: NS = IDLE;

            default: NS = IDLE;
        endcase
    end

//reg 

    //column count
    always @(posedge clk or posedge rst) begin
        if(rst)               col <= 7'd0;

        else if(CS == DELAY)  col <= 7'd0;

        else if(CS == GET)    col <= col + 7'd1;
        else                  col <= col;
    end


    //row count
    always @(posedge clk or posedge rst) begin
        if(rst) row <= 4'd0;

        else if(CS == TRANSMIT) row <= row + 4'd1;
    end

//output

    //row output
    always @(*) begin
        {D, C, B, A} = row - 4'd1;
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

        else 
        case (state)

            START:
            begin
                R0 <= menuMap[6143-(row*64+(col - 7'd1))*3];
                G0 <= menuMap[6142-(row*64+(col - 7'd1))*3];
                B0 <= menuMap[6141-(row*64+(col - 7'd1))*3];
                R1 <= menuMap[3071-(row*64+(col - 7'd1))*3];
                G1 <= menuMap[3070-(row*64+(col - 7'd1))*3];
                B1 <= menuMap[3069-(row*64+(col - 7'd1))*3];
            end

            MENU:
            begin
                R0 <= menuMap[6143-(row*64+(col - 7'd1))*3];
                G0 <= menuMap[6142-(row*64+(col - 7'd1))*3];
                B0 <= menuMap[6141-(row*64+(col - 7'd1))*3];
                R1 <= menuMap[3071-(row*64+(col - 7'd1))*3];
                G1 <= menuMap[3070-(row*64+(col - 7'd1))*3];
                B1 <= menuMap[3069-(row*64+(col - 7'd1))*3];
            end
            
            PLAY:
            begin
                if(row == 3) begin    
                    R0 <= scoreMap0[191-(col - 7'd1)*3];
                    G0 <= scoreMap0[190-(col - 7'd1)*3];
                    B0 <= scoreMap0[189-(col - 7'd1)*3];
                    if ((col - 7'd1)==7'd6) begin
                        R1 <= 1'b1;
                        G1 <= 1'b1;
                        B1 <= 1'b0;
                    end
                    else begin
                        R1 <= 1'b0;
                        G1 <= 1'b0;
                        B1 <= 1'b0;
                    end
                end
                else if(row == 4) begin    
                    R0 <= scoreMap1[191-(col - 7'd1)*3];
                    G0 <= scoreMap1[190-(col - 7'd1)*3];
                    B0 <= scoreMap1[189-(col - 7'd1)*3];
                    if ((col - 7'd1)==7'd6) begin
                        R1 <= 1'b1;
                        G1 <= 1'b1;
                        B1 <= 1'b0;
                    end
                    else begin
                        R1 <= 1'b0;
                        G1 <= 1'b0;
                        B1 <= 1'b0;
                    end
                end
                else if(row == 5) begin    
                    R0 <= scoreMap2[191-(col - 7'd1)*3];
                    G0 <= scoreMap2[190-(col - 7'd1)*3];
                    B0 <= scoreMap2[189-(col - 7'd1)*3];
                    R1 <= notesMap0[(col - 7'd1)*3+2];
                    G1 <= notesMap0[(col - 7'd1)*3+1];
                    B1 <= notesMap0[(col - 7'd1)*3];
                end
                else if(row == 6) begin    
                    R0 <= scoreMap3[191-(col - 7'd1)*3];
                    G0 <= scoreMap3[190-(col - 7'd1)*3];
                    B0 <= scoreMap3[189-(col - 7'd1)*3];
                    R1 <= notesMap1[(col - 7'd1)*3+2];
                    G1 <= notesMap1[(col - 7'd1)*3+1];
                    B1 <= notesMap1[(col - 7'd1)*3];
                end
                else if(row == 7) begin    
                    R0 <= scoreMap4[191-(col - 7'd1)*3];
                    G0 <= scoreMap4[190-(col - 7'd1)*3];
                    B0 <= scoreMap4[189-(col - 7'd1)*3];
                    R1 <= notesMap2[(col - 7'd1)*3+2];
                    G1 <= notesMap2[(col - 7'd1)*3+1];
                    B1 <= notesMap2[(col - 7'd1)*3];
                end
                else if(row == 8) begin    
                    R0 <= scoreMap5[191-(col - 7'd1)*3];
                    G0 <= scoreMap5[190-(col - 7'd1)*3];
                    B0 <= scoreMap5[189-(col - 7'd1)*3];
                    R1 <= notesMap3[(col - 7'd1)*3+2];
                    G1 <= notesMap3[(col - 7'd1)*3+1];
                    B1 <= notesMap3[(col - 7'd1)*3];
                end
                else if(row == 9) begin    
                    R0 <= scoreMap6[191-(col - 7'd1)*3];
                    G0 <= scoreMap6[190-(col - 7'd1)*3];
                    B0 <= scoreMap6[189-(col - 7'd1)*3];
                    R1 <= notesMap4[(col - 7'd1)*3+2];
                    G1 <= notesMap4[(col - 7'd1)*3+1];
                    B1 <= notesMap4[(col - 7'd1)*3];
                end
                else if(row == 10) begin    
                    R0 <= scoreMap7[191-(col - 7'd1)*3];
                    G0 <= scoreMap7[190-(col - 7'd1)*3];
                    B0 <= scoreMap7[189-(col - 7'd1)*3];
                    R1 <= notesMap5[(col - 7'd1)*3+2];
                    G1 <= notesMap5[(col - 7'd1)*3+1];
                    B1 <= notesMap5[(col - 7'd1)*3];
                end
                else if(row == 11) begin    
                    R0 <= scoreMap8[191-(col - 7'd1)*3];
                    G0 <= scoreMap8[190-(col - 7'd1)*3];
                    B0 <= scoreMap8[189-(col - 7'd1)*3];
                    R1 <= notesMap6[(col - 7'd1)*3+2];
                    G1 <= notesMap6[(col - 7'd1)*3+1];
                    B1 <= notesMap6[(col - 7'd1)*3];
                end
                else if(row == 12) begin    
                    R0 <= scoreMap9[191-(col - 7'd1)*3];
                    G0 <= scoreMap9[190-(col - 7'd1)*3];
                    B0 <= scoreMap9[189-(col - 7'd1)*3];
                    if ((col - 7'd1)==7'd6) begin
                        R1 <= 1'b1;
                        G1 <= 1'b1;
                        B1 <= 1'b0;
                    end
                    else begin
                        R1 <= 1'b0;
                        G1 <= 1'b0;
                        B1 <= 1'b0;
                    end
                end
                else if(row == 0) begin    
                    R1 <= 1'b1;
                    G1 <= 1'b0;
                    B1 <= 1'b1;
                    R0 <= 1'b0;
                    G0 <= 1'b0;
                    B0 <= 1'b0;
                end
                else begin
                    R0 <= 1'b0;
                    G0 <= 1'b0;
                    B0 <= 1'b0;
                    if ((col - 7'd1)==7'd6) begin
                        R1 <= 1'b1;
                        G1 <= 1'b1;
                        B1 <= 1'b0;
                    end
                    else begin
                        R1 <= 1'b0;
                        G1 <= 1'b0;
                        B1 <= 1'b0;
                    end
                end
            end
            FINISH: 
            begin
                if(row == 3) begin    
                    R0 <= scoreMap0[191-(col - 7'd1)*3];
                    G0 <= scoreMap0[190-(col - 7'd1)*3];
                    B0 <= scoreMap0[189-(col - 7'd1)*3];
                end
                else if(row == 4) begin    
                    R0 <= scoreMap1[191-(col - 7'd1)*3];
                    G0 <= scoreMap1[190-(col - 7'd1)*3];
                    B0 <= scoreMap1[189-(col - 7'd1)*3];
                end
                else if(row == 5) begin    
                    R0 <= scoreMap2[191-(col - 7'd1)*3];
                    G0 <= scoreMap2[190-(col - 7'd1)*3];
                    B0 <= scoreMap2[189-(col - 7'd1)*3];
                end
                else if(row == 6) begin    
                    R0 <= scoreMap3[191-(col - 7'd1)*3];
                    G0 <= scoreMap3[190-(col - 7'd1)*3];
                    B0 <= scoreMap3[189-(col - 7'd1)*3];
                end
                else if(row == 7) begin    
                    R0 <= scoreMap4[191-(col - 7'd1)*3];
                    G0 <= scoreMap4[190-(col - 7'd1)*3];
                    B0 <= scoreMap4[189-(col - 7'd1)*3];
                end
                else if(row == 8) begin    
                    R0 <= scoreMap5[191-(col - 7'd1)*3];
                    G0 <= scoreMap5[190-(col - 7'd1)*3];
                    B0 <= scoreMap5[189-(col - 7'd1)*3];
                end
                else if(row == 9) begin    
                    R0 <= scoreMap6[191-(col - 7'd1)*3];
                    G0 <= scoreMap6[190-(col - 7'd1)*3];
                    B0 <= scoreMap6[189-(col - 7'd1)*3];
                end
                else if(row == 10) begin    
                    R0 <= scoreMap7[191-(col - 7'd1)*3];
                    G0 <= scoreMap7[190-(col - 7'd1)*3];
                    B0 <= scoreMap7[189-(col - 7'd1)*3];
                end
                else if(row == 11) begin    
                    R0 <= scoreMap8[191-(col - 7'd1)*3];
                    G0 <= scoreMap8[190-(col - 7'd1)*3];
                    B0 <= scoreMap8[189-(col - 7'd1)*3];
                end
                else if(row == 12) begin    
                    R0 <= scoreMap9[191-(col - 7'd1)*3];
                    G0 <= scoreMap9[190-(col - 7'd1)*3];
                    B0 <= scoreMap9[189-(col - 7'd1)*3];
                end
                else begin
                    R0 <= 1'b0;
                    G0 <= 1'b0;
                    B0 <= 1'b0;
                end
                R1 <= 1'b0;
                G1 <= 1'b0;
                B1 <= 1'b0;
            end
            default: 
            begin
                R0 <= 1'b0;
                G0 <= 1'b0;
                B0 <= 1'b0;
                R1 <= 1'b0;
                G1 <= 1'b0;
                B1 <= 1'b0;
            end
        endcase
        
    end

    //OE, LAT output
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            OE  <= 1'd0;
            LAT <= 1'd0;
        end

        else begin

            if(NS == DELAY) begin
                OE  <= 1'd0;
                LAT <= 1'd0;
            end

            if(NS == GET) begin
                OE  <= 1'd1;
                LAT <= 1'd0;
            end
            else if(NS == TRANSMIT) begin
                OE  <= 1'd1;
                LAT <= 1'd1;
            end
            else if(NS == IDLE) begin
                OE  <= 1'd0;
                LAT <= 1'd0; 
            end
        end
    end

    endmodule
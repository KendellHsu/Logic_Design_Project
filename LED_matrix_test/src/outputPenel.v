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

The test output for RGB:
Multiples of 2 are white.
Multiples of 4 are blue.
Multiples of 8 are green.
Multiples of 16 are red.
Others aren't beaming.
*/

module matrix (
    input clk,
    input rst,                //positive edge
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


parameter IDLE = 2'd0, GET = 2'd1, TRANSMIT = 2'd2;

    //FSM
    always @(posedge clk or posedge rst) begin
        if(rst) CS <= IDLE;

        else       CS <= NS;
    end

    always @(*) begin
        case(CS)

            IDLE: NS = GET;

            GET: NS =(col == 7'd64)? TRANSMIT : GET;    //count 64 column

            TRANSMIT: NS = IDLE;

            default: NS = IDLE;
        endcase
    end

//reg 

    //column count
    always @(posedge clk or posedge rst) begin
        if(rst)               col <= 7'd0;

        else if(col == 7'd64) col <= 7'd0;

        else if(NS == GET)    col <= col + 7'd1;
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

        else if(row == 0) begin    
            R1 <= notesMap0[col*3+2];
            G1 <= notesMap0[col*3+1];
            B1 <= notesMap0[col*3];
        end
        else if(row == 1) begin    
            R1 <= notesMap1[col*3+2];
            G1 <= notesMap1[col*3+1];
            B1 <= notesMap1[col*3];
        end
        else if(row == 2) begin    
            R1 <= notesMap2[col*3+2];
            G1 <= notesMap2[col*3+1];
            B1 <= notesMap2[col*3];
        end
        else if(row == 3) begin    
            R1 <= notesMap3[col*3+2];
            G1 <= notesMap3[col*3+1];
            B1 <= notesMap3[col*3];
        end
        else if(row == 4) begin    
            R1 <= notesMap4[col*3+2];
            G1 <= notesMap4[col*3+1];
            B1 <= notesMap4[col*3];
        end
        else if(row == 5) begin    
            R1 <= notesMap5[col*3+2];
            G1 <= notesMap5[col*3+1];
            B1 <= notesMap5[col*3];
        end
        else if(row == 6) begin    
            R1 <= notesMap6[col*3+2];
            G1 <= notesMap6[col*3+1];
            B1 <= notesMap6[col*3];
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
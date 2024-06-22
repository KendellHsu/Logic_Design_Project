module drawNode(
    input [9:0] red_notes,  // 9-bit input for the notes
    input [9:0] blue_notes,
    input rst,
    input [2:0] offset,
    output reg [209:0] bitmap0,
    output reg [209:0] bitmap1,
    output reg [209:0] bitmap2,
    output reg [209:0] bitmap3,
    output reg [209:0] bitmap4,
    output reg [209:0] bitmap5,
    output reg [209:0] bitmap6  // 7x(64*3) output bitmap
);

// Define bitmaps for Note A and Note B
localparam red_bitmap0 = 21'b000000111111111000000;
localparam red_bitmap1 = 21'b000111100100100111000;
localparam red_bitmap2 = 21'b111100100100100100111;
localparam red_bitmap3 = 21'b111100100100100100111;
localparam red_bitmap4 = 21'b111100100100100100111;
localparam red_bitmap5 = 21'b000111100100100111000;
localparam red_bitmap6 = 21'b000000111111111000000;

localparam blue_bitmap0 = 21'b000000111111111000000;
localparam blue_bitmap1 = 21'b000111011011011111000;
localparam blue_bitmap2 = 21'b111011011011011011111;
localparam blue_bitmap3 = 21'b111011011011011011111;
localparam blue_bitmap4 = 21'b111011011011011011111;
localparam blue_bitmap5 = 21'b000111011011011111000;
localparam blue_bitmap6 = 21'b000000111111111000000;

integer i;

always @(*) begin
    if(rst) begin
         bitmap0 = 210'd0;
         bitmap1 = 210'd0;
         bitmap2 = 210'd0;
         bitmap3 = 210'd0;
         bitmap4 = 210'd0;
         bitmap5 = 210'd0;
         bitmap6 = 210'd0;
    end
    for (i = 0; i < 10; i = i + 1 ) begin
        if (red_notes[i]) begin
            bitmap0[i*7*3+:21] = red_bitmap0;
            bitmap1[i*7*3+:21] = red_bitmap1;
            bitmap2[i*7*3+:21] = red_bitmap2;
            bitmap3[i*7*3+:21] = red_bitmap3;
            bitmap4[i*7*3+:21] = red_bitmap4;
            bitmap5[i*7*3+:21] = red_bitmap5;
            bitmap6[i*7*3+:21] = red_bitmap6;
        end
        else if (blue_notes[i]) begin
            bitmap0[i*7*3+:21] = blue_bitmap0;
            bitmap1[i*7*3+:21] = blue_bitmap1;
            bitmap2[i*7*3+:21] = blue_bitmap2;
            bitmap3[i*7*3+:21] = blue_bitmap3;
            bitmap4[i*7*3+:21] = blue_bitmap4;
            bitmap5[i*7*3+:21] = blue_bitmap5;
            bitmap6[i*7*3+:21] = blue_bitmap6;
        end
        else begin
            bitmap0[i*7*3+:21] = 0;
            bitmap1[i*7*3+:21] = 0;
            bitmap2[i*7*3+:21] = 0;
            bitmap3[i*7*3+:21] = 0;
            bitmap4[i*7*3+:21] = 0;
            bitmap5[i*7*3+:21] = 0;
            bitmap6[i*7*3+:21] = 0;
        end
    end
    bitmap0 = bitmap0 >> offset*3;
    bitmap1 = bitmap1 >> offset*3;
    bitmap2 = bitmap2 >> offset*3;
    bitmap3 = bitmap3 >> offset*3;
    bitmap4 = bitmap4 >> offset*3;
    bitmap5 = bitmap5 >> offset*3;
    bitmap6 = bitmap6 >> offset*3;
end

endmodule

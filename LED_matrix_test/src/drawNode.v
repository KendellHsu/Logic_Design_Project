module drawNode(
    input [9:0] red_notes,  // 9-bit input for the notes
    input [9:0] blue_notes,
    input [2:0] offset,
    output reg [191:0] bitmap0 = 0,
    output reg [191:0] bitmap1 = 0,
    output reg [191:0] bitmap2 = 0,
    output reg [191:0] bitmap3 = 0,
    output reg [191:0] bitmap4 = 0,
    output reg [191:0] bitmap5 = 0,
    output reg [191:0] bitmap6 = 0 // 7x(64*3) output bitmap
);

// Define bitmaps for Note A and Note B
localparam red_bitmap0 = 21'b000000111111111000000;
localparam red_bitmap1 = 21'b000111100100100111000;
localparam red_bitmap2 = 21'b111100000100000100111;
localparam red_bitmap3 = 21'b111100100100100100111;
localparam red_bitmap4 = 21'b111100100111100100111;
localparam red_bitmap5 = 21'b000111100100100111000;
localparam red_bitmap6 = 21'b000000111111111000000;

localparam blue_bitmap0 = 21'b000000111111111000000;
localparam blue_bitmap1 = 21'b000111011011011111000;
localparam blue_bitmap2 = 21'b111000000011000000111;
localparam blue_bitmap3 = 21'b111011011011011011111;
localparam blue_bitmap4 = 21'b111011011111011011111;
localparam blue_bitmap5 = 21'b000111011011011111000;
localparam blue_bitmap6 = 21'b000000111111111000000;

integer i;

always @(offset) begin
    for (i = 0; i < 10; i = i + 1 ) begin
        if (red_notes[i]) begin
            bitmap0[i*7*3-offset*3+:21] <= red_bitmap0;
            bitmap1[i*7*3-offset*3+:21] <= red_bitmap1;
            bitmap2[i*7*3-offset*3+:21] <= red_bitmap2;
            bitmap3[i*7*3-offset*3+:21] <= red_bitmap3;
            bitmap4[i*7*3-offset*3+:21] <= red_bitmap4;
            bitmap5[i*7*3-offset*3+:21] <= red_bitmap5;
            bitmap6[i*7*3-offset*3+:21] <= red_bitmap6;
        end
        else if (blue_notes[i]) begin
            bitmap0[i*7*3-offset*3+:21] <= blue_bitmap0;
            bitmap1[i*7*3-offset*3+:21] <= blue_bitmap1;
            bitmap2[i*7*3-offset*3+:21] <= blue_bitmap2;
            bitmap3[i*7*3-offset*3+:21] <= blue_bitmap3;
            bitmap4[i*7*3-offset*3+:21] <= blue_bitmap4;
            bitmap5[i*7*3-offset*3+:21] <= blue_bitmap5;
            bitmap6[i*7*3-offset*3+:21] <= blue_bitmap6;
        end
        else begin
            bitmap0[i*7*3-offset*3+:21] = 0;
            bitmap1[i*7*3-offset*3+:21] = 0;
            bitmap2[i*7*3-offset*3+:21] = 0;
            bitmap3[i*7*3-offset*3+:21] = 0;
            bitmap4[i*7*3-offset*3+:21] = 0;
            bitmap5[i*7*3-offset*3+:21] = 0;
            bitmap6[i*7*3-offset*3+:21] = 0;
        end
    end
    // //處理第一個位置
    // if (red_notes[0]) begin
    //     bitmap0[20-offset:0] <= red_bitmap0;
    //     bitmap1[20-offset:0] <= red_bitmap1;
    //     bitmap2[20-offset:0] <= red_bitmap2;
    //     bitmap3[20-offset:0] <= red_bitmap3;
    //     bitmap4[20-offset:0] <= red_bitmap4;
    //     bitmap5[20-offset:0] <= red_bitmap5;
    //     bitmap6[20-offset:0] <= red_bitmap6;
    // end
    // else if (blue_notes[0]) begin
    //     bitmap0[20-offset:0] <= blue_bitmap0;
    //     bitmap1[20-offset:0] <= blue_bitmap1;
    //     bitmap2[20-offset:0] <= blue_bitmap2;
    //     bitmap3[20-offset:0] <= blue_bitmap3;
    //     bitmap4[20-offset:0] <= blue_bitmap4;
    //     bitmap5[20-offset:0] <= blue_bitmap5;
    //     bitmap6[20-offset:0] <= blue_bitmap6;
    // end
    // else begin
    //     bitmap0[20-offset:0] = 0;
    //     bitmap1[20-offset:0] = 0;
    //     bitmap2[20-offset:0] = 0;
    //     bitmap3[20-offset:0] = 0;
    //     bitmap4[20-offset:0] = 0;
    //     bitmap5[20-offset:0] = 0;
    //     bitmap6[20-offset:0] = 0;
    // end
end

endmodule

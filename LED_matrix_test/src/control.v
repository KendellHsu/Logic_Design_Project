`include "outputPenel.v"
`include "shift.v"
`include "drawNode.v"
`include "clk_div.v"
module control(
    input clk,
    input rst,
    input [1:0] bottom,
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

    wire clk_div;
    wire finish;
    wire [9:0] note_R;
    wire [9:0] note_B;
    wire [3:0] offset;
    wire [191:0] bitmap0;
    wire [191:0] bitmap1;
    wire [191:0] bitmap2;
    wire [191:0] bitmap3;
    wire [191:0] bitmap4;
    wire [191:0] bitmap5;
    wire [191:0] bitmap6;

    clk_div CLK(
        .clk(clk_div),
        .rst(rst),
        .clk_div(clk_div)
    );

    shift_load SH1(
        .clk(clk_div),
        .rst(rst),
        .song(bottom),
        .note_R(note_R),
        .note_B(note_B),
        .offset(offset),
        .finish(finish)
        );
    drawNode DN1(
        .red_notes(note_R),
        .blue_notes(note_B),
        .offset(offset),
        .bitmap0(bitmap0),
        .bitmap1(bitmap1),
        .bitmap2(bitmap2),
        .bitmap3(bitmap3),
        .bitmap4(bitmap4),
        .bitmap5(bitmap5),
        .bitmap6(bitmap6),
    );

    matrix M1(
        .clk(clk_div),
        .rst(rst),
        .bitmap0(bitmap0),
        .bitmap1(bitmap1),
        .bitmap2(bitmap2),
        .bitmap3(bitmap3),
        .bitmap4(bitmap4),
        .bitmap5(bitmap5),
        .bitmap6(bitmap6),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .R0(R0),
        .G0(G0),
        .B0(B0),
        .R1(R1),
        .G1(G1),
        .B1(B1),
        .oE(OE),
        .LAT(LAT)
    ); 
    
endmodule
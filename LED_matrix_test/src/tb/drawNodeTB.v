`timescale 1ns/1ns
`include "drawNode.v"
`define cycle 10

module tb;

reg [9:0] a; // 9-bit input
reg [9:0] b; // 9-bit input
reg [2:0] offset;
wire [191:0] z0; // 192-bit outputs
wire [191:0] z1;
wire [191:0] z2;
wire [191:0] z3;
wire [191:0] z4;
wire [191:0] z5;
wire [191:0] z6;

drawNode draw(
    .red_notes(a),
    .blue_notes(b),
    .offset(offset), 
    .bitmap0(z0), 
    .bitmap1(z1), 
    .bitmap2(z2), 
    .bitmap3(z3), 
    .bitmap4(z4), 
    .bitmap5(z5), 
    .bitmap6(z6)
);

initial begin
    a = 10'b01100001010;
    b = 10'b00001010000;
    offset = 0;
    #(`cycle);
    offset = 1;
    #(`cycle);
    offset = 2;
    #(`cycle);
    offset = 3;
    #(`cycle);
    offset = 4;
    #(`cycle);
    offset = 5;
    #(`cycle);
    offset = 6;
    #(`cycle);
    a = 10'b00110000101;
    b = 10'b00000101000;
    offset = 0;
    #(`cycle);
    offset = 1;
    #(`cycle);
    offset = 2;
    #(`cycle);
    offset = 3;
    #(`cycle);
    offset = 4;
    #(`cycle);
    offset = 5;
    #(`cycle);
    offset = 6;
    #(`cycle);
    $finish;
end

endmodule

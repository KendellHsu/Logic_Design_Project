`timescale 1ps/1ps

module tb;

    reg clk;
    reg rst;
    reg [1:0] song;
    wire A; 
    wire B;
    wire C;
    wire D;
    wire R0;
    wire G0;
    wire B0;
    wire R1;
    wire G1;
    wire B1;
    wire OE;
    wire LAT;

    control c1(
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .R0(R0),
        .G0(G0),
        .B0(B0),
        .R1(R0),
        .G1(G0),
        .B1(B0),
        .OE(OE),
        .LAT(LAT)
    );

    initial begin
        clk =0;
        rst =0;
        song = 2'd0;


    #10 rst = 0;
    #20 song = 2'd1;
    #10 song = 2'd0;

    #10000000000;

    $stop;
    end





endmodule
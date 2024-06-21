`timescale 1ps/1ps

module tb;

    reg clk;
    reg rst;
    reg bottom;
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

    // Instantiate the control module
    control c1(
        .clk(clk),
        .rst(rst),
        //.bottom(bottom),
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
        .OE(OE),
        .LAT(LAT)
    );

    initial begin
        clk = 0;
        rst = 1;
        // Reset the design
        #10 rst = 0;
        //#20 bottom = 2'd1;


        // Run for a while
        #100000000;

        // Finish simulation
        $stop;
    end

    // Clock generation
    always #5 clk = ~clk; // 100MHz clock

endmodule

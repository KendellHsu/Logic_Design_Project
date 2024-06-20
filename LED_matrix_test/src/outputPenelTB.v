`timescale 1ps/1ps
module testbench;

  // Inputs
  reg clk;
  reg rst;
  reg [191:0] notesMap0;
  reg [191:0] notesMap1;
  reg [191:0] notesMap2;
  reg [191:0] notesMap3;
  reg [191:0] notesMap4;
  reg [191:0] notesMap5;
  reg [191:0] notesMap6;

  // Outputs
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

  // Instantiate the Unit Under Test (UUT)
  matrix uut (
    .clk(clk),
    .rst(rst),
    .notesMap0(notesMap0),
    .notesMap1(notesMap1),
    .notesMap2(notesMap2),
    .notesMap3(notesMap3),
    .notesMap4(notesMap4),
    .notesMap5(notesMap5),
    .notesMap6(notesMap6),
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

  // Clock generation
  always #5 clk = ~clk; // 100MHz clock

  initial begin
    // Initialize Inputs
    clk = 0;
    rst = 1;
    notesMap0 = 192'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    notesMap1 = 192'h5555555555555555555555555555555555555555555555555555555555555555;
    notesMap2 = 192'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    notesMap3 = 192'h0000000000000000000000000000000000000000000000000000000000000000;
    notesMap4 = 192'h1111111111111111111111111111111111111111111111111111111111111111;
    notesMap5 = 192'h2222222222222222222222222222222222222222222222222222222222222222;
    notesMap6 = 192'h3333333333333333333333333333333333333333333333333333333333333333;

    // Reset the design
    #10 rst = 0;

    // Run for a while
    #1000000;

    // Finish simulation
    $stop;
  end

endmodule

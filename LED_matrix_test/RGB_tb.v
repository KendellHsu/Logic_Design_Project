`timescale 1ns/1ps

module matrix_tb;

    // Inputs
    reg clk;
    reg rst;

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


    // Instantiate the matrix module
    LED_top uut (
        .clk(clk),
        .rst(rst),
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
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        rst = 1;
        #20 rst = 0;

        // Monitor outputs
        $monitor("Time: %d, A: %b, B: %b, C: %b, D: %b, R0: %b, G0: %b, B0: %b, R1: %b, G1: %b, B1: %b, OE: %b, LAT: %b", 
                 $time, A, B, C, D, R0, G0, B0, R1, G1, B1, OE, LAT);

        // Run for a certain amount of time to observe behavior
        #15000000 $finish;
    end

    // Additional tasks for checking specific functionalities
    task check_initial;
        begin
            if (A !== 0 || B !== 0 || C !== 0 || D !== 0 || R0 !== 0 || G0 !== 0 || B0 !== 0 || R1 !== 0 || G1 !== 0 || B1 !== 0 || OE !== 0 || LAT !== 0) begin
                $display("Initial state check failed.");
                $stop;
            end else begin
                $display("Initial state check passed.");
            end
        end
    endtask

    // Call the check tasks
    initial begin
        #25 check_initial;
    end

endmodule

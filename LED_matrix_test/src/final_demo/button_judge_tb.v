module tb_button_judge();

    reg clk;
    reg rst;
    reg red_button;
    reg blue_button;
    reg [2:0] offset;
    reg node_R;
    reg node_B;
    wire delete_note;
    wire [1:0] score;

    // Instantiate the button_judge module
    button_judge uut (
        .clk(clk),
        .rst(rst),
        .red_button(red_button),
        .blue_button(blue_button),
        .offset(offset),
        .node_R(node_R),
        .node_B(node_B),
        .delete_note(delete_note),
        .score(score)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns period clock

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        red_button = 0;
        blue_button = 0;
        offset = 0;
        node_R = 0;
        node_B = 0;

        // Reset the system
        #10 rst = 0;
        
        // Test 1: Red button press with perfect offset
        #10 offset = 3'd3; node_R = 1; red_button = 1;
        #10 red_button = 0; node_R = 0; // Release button

        // Test 2: Blue button press with late offset
        #10 offset = 3'd5; node_B = 1; blue_button = 1;
        #10 blue_button = 0; node_B = 0; // Release button

        // Test 3: Red button press with early offset
        #10 offset = 3'd1; node_R = 1; red_button = 1;
        #10 red_button = 0; node_R = 0; // Release button

        // Test 4: Blue button press with no valid offset
        #10 offset = 3'd0; node_B = 1; blue_button = 1;
        #10 blue_button = 0; node_B = 0; // Release button

        // Test 5: Press and hold red button (should only register once)
        #10 offset = 3'd4; node_R = 1; red_button = 1;
        #10 red_button = 1;
        #10 red_button = 0; node_R = 0; // Release button

        // Test 6: Press and hold blue button (should only register once)
        #10 offset = 3'd2; node_B = 1; blue_button = 1;
        #10 blue_button = 1;
        #10 blue_button = 0; node_B = 0; // Release button

        // Add more tests if needed

        // Finish simulation
        #50 $finish;
    end

    initial begin
        $monitor("At time %t, rst = %b, red_button = %b, blue_button = %b, offset = %d, node_R = %b, node_B = %b, delete_note = %b, score = %b",
                 $time, rst, red_button, blue_button, offset, node_R, node_B, delete_note, score);
    end
endmodule

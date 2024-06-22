module tb_state_button;

    // Inputs
    reg clk;
    reg rst;
    reg finish;
    reg red_button;
    reg blue_button;
    reg yellow_button;

    // Outputs
    wire [1:0] song_confirm;
    wire [1:0] state;

    // Instantiate the Unit Under Test (UUT)
    state_button uut (
        .clk(clk),
        .rst(rst),
        .finish(finish),
        .red_button(red_button),
        .blue_button(blue_button),
        .yellow_button(yellow_button),
        .song_confirm(song_confirm),
        .state(state)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz clock
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        rst = 1;
        finish = 0;
        red_button = 0;
        blue_button = 0;
        yellow_button = 0;

        // Wait for the global reset
        #20;
        rst = 0;

        // Test sequence
        // Start state to MENU
        #10;
        red_button = 1;  // Simulate red button press
        #100;
        red_button = 0;  // Simulate red button release

        // MENU state to PLAY state
        #150;
        yellow_button = 1;  // Simulate yellow button press
        #200;
        yellow_button = 0;  // Simulate yellow button release

        // Simulate playing the song and then finishing it
        #250;
        finish = 1;  // Simulate finish
        #300;
        finish = 0;  // Simulate finish release

        // Transition from FINISH back to MENU
        #10;
        yellow_button = 1;  // Simulate yellow button press
        #10;
        yellow_button = 0;  // Simulate yellow button release

        // Finish simulation
        #100;
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time: %0t, rst: %b, finish: %b, red_button: %b, blue_button: %b, yellow_button: %b, song_confirm: %b, state: %b",
                 $time, rst, finish, red_button, blue_button, yellow_button, song_confirm, state);
    end

endmodule

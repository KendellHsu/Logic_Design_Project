`timescale 1ns/1ps

module tb_draw_main_scene;

    reg clk;
    reg rst;
    reg [1:0] current_state;
    reg [1:0] selected_song;
    wire [6143:0] menuMap;

    // Instantiate the Unit Under Test (UUT)
    draw_main_scene uut (
        .clk(clk),
        .rst(rst),
        .current_state(current_state),
        .selected_song(selected_song),
        .menuMap(menuMap)
    );

    // Clock generation
    always #5 clk = ~clk; // 100MHz clock

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        current_state = 2'b00;
        selected_song = 2'b00;

        // Apply reset
        #10;
        rst = 0;

        // Test START_SCENE with animation
        current_state = 2'b00;
        #100000; // Wait for some cycles to see the animation

        // Test SONG_SELECT with rick roll song
        current_state = 2'b01;
        selected_song = 2'b00;
        #100000; // Wait for some cycles to see the animation

        // Test SONG_SELECT with yare yare song
        selected_song = 2'b01;
        #100000; // Wait for some cycles to see the animation

        // Test SONG_SELECT with maddeo song
        selected_song = 2'b10;
        #100000; // Wait for some cycles to see the animation

        // Test GAME_PLAY state
        current_state = 2'b10;
        #100000; // Wait for some cycles

        // Test GAME_OVER state
        current_state = 2'b11;
        #100000; // Wait for some cycles

        // Finish simulation
        $stop;
    end

endmodule

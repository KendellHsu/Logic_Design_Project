module tb_shift_load;
  reg clk;
  reg rst;
  reg [1:0] song;
  wire [9:0] note_R;
  wire [9:0] note_G;
  //wire [9:0] note_B;
  wire [3:0] offset;
  wire finish;

  // 实例化被测试模块
  shift_load uut (
    .clk(clk),
    .rst(rst),
    .song(song),
    .note_R(note_R),
    .note_G(note_G),
    //.note_B(note_B),
    .offset(offset),
    .finish(finish)
  );

  // 生成时钟信号
  always #5 clk = ~clk; // 10ns时钟周期

  initial begin
    // 初始化输入信号
    clk = 0;
    rst = 1;
    song = 2'd0;

    // 复位操作
    #10 rst = 0;

    // 设置song信号为1，持续一个时钟周期后拉低
    #20 song = 2'd1;
    #10 song = 2'd0;

    // 等待finish信号为1
    wait(finish == 1);
    
    // 结束模拟
    #10 $finish;
  end

  // 打印输出信号，便于调试
  initial begin
    $monitor("Time: %0d, offset: %0d, note_R: %b, note_G: %b, finish: %b", 
             $time, offset, note_R, note_G, finish);
  end

endmodule

module draw_score(

    input [15:0] score ,
    output reg [191:0] num0 ,
    output reg [191:0] num1 ,
    output reg [191:0] num2 ,
    output reg [191:0] num3 ,
    output reg [191:0] num4 ,
    output reg [191:0] num5 ,
    output reg [191:0] num6 ,
    output reg [191:0] num7 ,
    output reg [191:0] num8 ,
    output reg [191:0] num9   // 7x(64*3) output bitmap
);

initial begin
    num0 = 0;
    num1 = 0;
    num2 = 0;
    num3 = 0;
    num4 = 0;
    num5 = 0;
    num6 = 0;
    num7 = 0;
    num8 = 0;
    num9 = 0;
end
// Define bitmaps for Note A and Note B
localparam num0_0 = 30'b000000000000000000000000000000;
localparam num1_0 = 30'b000000000111111111111000000000;
localparam num2_0 = 30'b000000111000000000000111000000;
localparam num3_0 = 30'b000111111000000000000111111000;
localparam num4_0 = 30'b000111111000000000000111111000;
localparam num5_0 = 30'b000111111000000000000111111000;
localparam num6_0 = 30'b000111111000000000000111111000;
localparam num7_0 = 30'b000000111000000000000111000000;
localparam num8_0 = 30'b000000000111111111111000000000;
localparam num9_0 = 30'b000000000000000000000000000000;

localparam num0_1 = 30'b000000000000000000000000000000;
localparam num1_1 = 30'b000000000011111111000000000000;
localparam num2_1 = 30'b000000011111111111000000000000;
localparam num3_1 = 30'b000011111000111111000000000000;
localparam num4_1 = 30'b000000000000111111000000000000;
localparam num5_1 = 30'b000000000000111111000000000000;
localparam num6_1 = 30'b000000000000111111000000000000;
localparam num7_1 = 30'b000000000000111111000000000000;
localparam num8_1 = 30'b000111111111111111111111111000;
localparam num9_1 = 30'b000000000000000000000000000000;

localparam num0_2 = 30'b000000000000000000000000000000;
localparam num1_2 = 30'b000000000111111111111000000000;
localparam num2_2 = 30'b000000111111000000111111000000;
localparam num3_2 = 30'b000000111000000000111111000000;
localparam num4_2 = 30'b000000000000000111111000000000;
localparam num5_2 = 30'b000000000000111111000000000000;
localparam num6_2 = 30'b000000000111111000000000000000;
localparam num7_2 = 30'b000000111111000000000111000000;
localparam num8_2 = 30'b000000111111111111111111000000;
localparam num9_2 = 30'b000000000000000000000000000000;

localparam num0_3 = 30'b000000000000000000000000000000;
localparam num1_3 = 30'b00000001111111111111111000000;
localparam num2_3 = 30'b000000111000000000111111000000;
localparam num3_3 = 30'b000000000000000000111111000000;
localparam num4_3 = 30'b000000000000000000111000000000;
localparam num5_3 = 30'b000000000111111111111111000000;
localparam num6_3 = 30'b000000000000000000111111000000;
localparam num7_3 = 30'b000000111000000000111111000000;
localparam num8_3 = 30'b000000000111111111111000000000;
localparam num9_3 = 30'b000000000000000000000000000000;

localparam num0_4 = 30'b000000000000000000000000000000;
localparam num1_4 = 30'b000000000000000000111000000000;
localparam num2_4 = 30'b000000000000000111111000000000;
localparam num3_4 = 30'b000000000000111000111000000000;
localparam num4_4 = 30'b000000000111000000111000000000;
localparam num5_4 = 30'b000000111000000000111000000000;
localparam num6_4 = 30'b000000111111111111111111111000;
localparam num7_4 = 30'b000000000000000000111000000000;
localparam num8_4 = 30'b000000000000000000111000000000;
localparam num9_4 = 30'b000000000000000000000000000000;

localparam num0_5 = 30'b000000000000000000000000000000;
localparam num1_5 = 30'b000000111111111111111111000000;
localparam num2_5 = 30'b000000111000000000000000000000;
localparam num3_5 = 30'b000000111000000000000000000000;
localparam num4_5 = 30'b000000111111111111111111000000;
localparam num5_5 = 30'b000000000000000000000111000000;
localparam num6_5 = 30'b000000000000000000000111000000;
localparam num7_5 = 30'b000000111000000000000111000000;
localparam num8_5 = 30'b000000111111111111111111000000;
localparam num9_5 = 30'b000000000000000000000000000000;

localparam num0_6 = 30'b000000000000000000000000000000;
localparam num1_6 = 30'b000000111111111111111111000000;
localparam num2_6 = 30'b000000111000000000000000000000;
localparam num3_6 = 30'b000000111000000000000000000000;
localparam num4_6 = 30'b000000111000000000000000000000;
localparam num5_6 = 30'b000000111111111111111111000000;
localparam num6_6 = 30'b000000111000000000000111000000;
localparam num7_6 = 30'b000000111000000000000111000000;
localparam num8_6 = 30'b000000111111111111111111000000;
localparam num9_6 = 30'b000000000000000000000000000000;

localparam num0_7 = 30'b000000000000000000000000000000;
localparam num1_7 = 30'b000000111111111111111111000000;
localparam num2_7 = 30'b000000111000000000000111000000;
localparam num3_7 = 30'b000000111000000000000111000000;
localparam num4_7 = 30'b000000000000000000000111000000;
localparam num5_7 = 30'b000000000000000000000111000000;
localparam num6_7 = 30'b000000000000000000000111000000;
localparam num7_7 = 30'b000000000000000000000111000000;
localparam num8_7 = 30'b000000000000000000000111000000;
localparam num9_7 = 30'b000000000000000000000000000000;

localparam num0_8 = 30'b000000000000000000000000000000;
localparam num1_8 = 30'b000000000111111111111000000000;
localparam num2_8 = 30'b000000111000000000000111000000;
localparam num3_8 = 30'b000000111000000000000111000000;
localparam num4_8 = 30'b000000000111111111111000000000;
localparam num5_8 = 30'b000000111000000000000111000000;
localparam num6_8 = 30'b000000111000000000000111000000;
localparam num7_8 = 30'b000000111000000000000111000000;
localparam num8_8 = 30'b000000000111111111111000000000;
localparam num9_8 = 30'b000000000000000000000000000000;

localparam num0_9 = 30'b000000000000000000000000000000;
localparam num1_9 = 30'b000000111111111111111111000000;
localparam num2_9 = 30'b000000111000000000000111000000;
localparam num3_9 = 30'b000000111000000000000111000000;
localparam num4_9 = 30'b000000111111111111111111000000;
localparam num5_9 = 30'b000000000000000000000111000000;
localparam num6_9 = 30'b000000000000000000000111000000;
localparam num7_9 = 30'b000000000000000000000111000000;
localparam num8_9 = 30'b000000111111111111111111000000;
localparam num9_9 = 30'b000000000000000000000000000000;

always @(score) begin
    
    case(score%10)
        0: begin
           num0[183:156] = num0_0;
           num1[183:156] = num1_0;
           num2[183:156] = num2_0;
           num3[183:156] = num3_0;
           num4[183:156] = num4_0;
           num5[183:156] = num5_0;
           num6[183:156] = num6_0;
           num7[183:156] = num7_0;
           num8[183:156] = num8_0;
           num9[183:156] = num9_0;
           end
        1: begin
           num0[183:156] = num0_1;
           num1[183:156] = num1_1;
           num2[183:156] = num2_1;
           num3[183:156] = num3_1;
           num4[183:156] = num4_1;
           num5[183:156] = num5_1;
           num6[183:156] = num6_1;
           num7[183:156] = num7_1;
           num8[183:156] = num8_1;
           num9[183:156] = num9_1;
           end
        2: begin
           num0[183:156] = num0_2;
           num1[183:156] = num1_2;
           num2[183:156] = num2_2;
           num3[183:156] = num3_2;
           num4[183:156] = num4_2;
           num5[183:156] = num5_2;
           num6[183:156] = num6_2;
           num7[183:156] = num7_2;
           num8[183:156] = num8_2;
           num9[183:156] = num9_2;
           end
        3: begin
           num0[183:156] = num0_3;
           num1[183:156] = num1_3;
           num2[183:156] = num2_3;
           num3[183:156] = num3_3;
           num4[183:156] = num4_3;
           num5[183:156] = num5_3;
           num6[183:156] = num6_3;
           num7[183:156] = num7_3;
           num8[183:156] = num8_3;
           num9[183:156] = num9_3;
           end
        4: begin
           num0[183:156] = num0_4;
           num1[183:156] = num1_4;
           num2[183:156] = num2_4;
           num3[183:156] = num3_4;
           num4[183:156] = num4_4;
           num5[183:156] = num5_4;
           num6[183:156] = num6_4;
           num7[183:156] = num7_4;
           num8[183:156] = num8_4;
           num9[183:156] = num9_4;
           end
        5: begin
           num0[183:156] = num0_5;
           num1[183:156] = num1_5;
           num2[183:156] = num2_5;
           num3[183:156] = num3_5;
           num4[183:156] = num4_5;
           num5[183:156] = num5_5;
           num6[183:156] = num6_5;
           num7[183:156] = num7_5;
           num8[183:156] = num8_5;
           num9[183:156] = num9_5;
           end
        6: begin
           num0[183:156] = num0_6;
           num1[183:156] = num1_6;
           num2[183:156] = num2_6;
           num3[183:156] = num3_6;
           num4[183:156] = num4_6;
           num5[183:156] = num5_6;
           num6[183:156] = num6_6;
           num7[183:156] = num7_6;
           num8[183:156] = num8_6;
           num9[183:156] = num9_6;
           end
        7: begin
           num0[183:156] = num0_7;
           num1[183:156] = num1_7;
           num2[183:156] = num2_7;
           num3[183:156] = num3_7;
           num4[183:156] = num4_7;
           num5[183:156] = num5_7;
           num6[183:156] = num6_7;
           num7[183:156] = num7_7;
           num8[183:156] = num8_7;
           num9[183:156] = num9_7;
           end
        8: begin
           num0[183:156] = num0_8;
           num1[183:156] = num1_8;
           num2[183:156] = num2_8;
           num3[183:156] = num3_8;
           num4[183:156] = num4_8;
           num5[183:156] = num5_8;
           num6[183:156] = num6_8;
           num7[183:156] = num7_8;
           num8[183:156] = num8_8;
           num9[183:156] = num9_8;
           end
        9: begin
           num0[183:156] = num0_9;
           num1[183:156] = num1_9;
           num2[183:156] = num2_9;
           num3[183:156] = num3_9;
           num4[183:156] = num4_9;
           num5[183:156] = num5_9;
           num6[183:156] = num6_9;
           num7[183:156] = num7_9;
           num8[183:156] = num8_9;
           num9[183:156] = num9_9;
           end               
    endcase
        
    case((score/10)%10)
        0: begin
           num0[147:120] = num0_0;
           num1[147:120] = num1_0;
           num2[147:120] = num2_0;
           num3[147:120] = num3_0;
           num4[147:120] = num4_0;
           num5[147:120] = num5_0;
           num6[147:120] = num6_0;
           num7[147:120] = num7_0;
           num8[147:120] = num8_0;
           num9[147:120] = num9_0;
           end
        1: begin
           num0[147:120] = num0_1;
           num1[147:120] = num1_1;
           num2[147:120] = num2_1;
           num3[147:120] = num3_1;
           num4[147:120] = num4_1;
           num5[147:120] = num5_1;
           num6[147:120] = num6_1;
           num7[147:120] = num7_1;
           num8[147:120] = num8_1;
           num9[147:120] = num9_1;
           end
        2: begin
           num0[147:120] = num0_2;
           num1[147:120] = num1_2;
           num2[147:120] = num2_2;
           num3[147:120] = num3_2;
           num4[147:120] = num4_2;
           num5[147:120] = num5_2;
           num6[147:120] = num6_2;
           num7[147:120] = num7_2;
           num8[147:120] = num8_2;
           num9[147:120] = num9_2;
           end
        3: begin
           num0[147:120] = num0_3;
           num1[147:120] = num1_3;
           num2[147:120] = num2_3;
           num3[147:120] = num3_3;
           num4[147:120] = num4_3;
           num5[147:120] = num5_3;
           num6[147:120] = num6_3;
           num7[147:120] = num7_3;
           num8[147:120] = num8_3;
           num9[147:120] = num9_3;
           end
        4: begin
           num0[147:120] = num0_4;
           num1[147:120] = num1_4;
           num2[147:120] = num2_4;
           num3[147:120] = num3_4;
           num4[147:120] = num4_4;
           num5[147:120] = num5_4;
           num6[147:120] = num6_4;
           num7[147:120] = num7_4;
           num8[147:120] = num8_4;
           num9[147:120] = num9_4;
           end
        5: begin
           num0[147:120] = num0_5;
           num1[147:120] = num1_5;
           num2[147:120] = num2_5;
           num3[147:120] = num3_5;
           num4[147:120] = num4_5;
           num5[147:120] = num5_5;
           num6[147:120] = num6_5;
           num7[147:120] = num7_5;
           num8[147:120] = num8_5;
           num9[147:120] = num9_5;
           end
        6: begin
           num0[147:120] = num0_6;
           num1[147:120] = num1_6;
           num2[147:120] = num2_6;
           num3[147:120] = num3_6;
           num4[147:120] = num4_6;
           num5[147:120] = num5_6;
           num6[147:120] = num6_6;
           num7[147:120] = num7_6;
           num8[147:120] = num8_6;
           num9[147:120] = num9_6;
           end
        7: begin
           num0[147:120] = num0_7;
           num1[147:120] = num1_7;
           num2[147:120] = num2_7;
           num3[147:120] = num3_7;
           num4[147:120] = num4_7;
           num5[147:120] = num5_7;
           num6[147:120] = num6_7;
           num7[147:120] = num7_7;
           num8[147:120] = num8_7;
           num9[147:120] = num9_7;
           end
        8: begin
           num0[147:120] = num0_8;
           num1[147:120] = num1_8;
           num2[147:120] = num2_8;
           num3[147:120] = num3_8;
           num4[147:120] = num4_8;
           num5[147:120] = num5_8;
           num6[147:120] = num6_8;
           num7[147:120] = num7_8;
           num8[147:120] = num8_8;
           num9[147:120] = num9_8;
           end
        9: begin
           num0[147:120] = num0_9;
           num1[147:120] = num1_9;
           num2[147:120] = num2_9;
           num3[147:120] = num3_9;
           num4[147:120] = num4_9;
           num5[147:120] = num5_9;
           num6[147:120] = num6_9;
           num7[147:120] = num7_9;
           num8[147:120] = num8_9;
           num9[147:120] = num9_9;
           end
    endcase
    
    case((score/100)%10)
        0: begin
           num0[111:84] = num0_0;
           num1[111:84] = num1_0;
           num2[111:84] = num2_0;
           num3[111:84] = num3_0;
           num4[111:84] = num4_0;
           num5[111:84] = num5_0;
           num6[111:84] = num6_0;
           num7[111:84] = num7_0;
           num8[111:84] = num8_0;
           num9[111:84] = num9_0;
           end
        1: begin
           num0[111:84] = num0_1;
           num1[111:84] = num1_1;
           num2[111:84] = num2_1;
           num3[111:84] = num3_1;
           num4[111:84] = num4_1;
           num5[111:84] = num5_1;
           num6[111:84] = num6_1;
           num7[111:84] = num7_1;
           num8[111:84] = num8_1;
           num9[111:84] = num9_1;
           end
        2: begin
           num0[111:84] = num0_2;
           num1[111:84] = num1_2;
           num2[111:84] = num2_2;
           num3[111:84] = num3_2;
           num4[111:84] = num4_2;
           num5[111:84] = num5_2;
           num6[111:84] = num6_2;
           num7[111:84] = num7_2;
           num8[111:84] = num8_2;
           num9[111:84] = num9_2;
           end
        3: begin
           num0[111:84] = num0_3;
           num1[111:84] = num1_3;
           num2[111:84] = num2_3;
           num3[111:84] = num3_3;
           num4[111:84] = num4_3;
           num5[111:84] = num5_3;
           num6[111:84] = num6_3;
           num7[111:84] = num7_3;
           num8[111:84] = num8_3;
           num9[111:84] = num9_3;
           end
        4: begin
           num0[111:84] = num0_4;
           num1[111:84] = num1_4;
           num2[111:84] = num2_4;
           num3[111:84] = num3_4;
           num4[111:84] = num4_4;
           num5[111:84] = num5_4;
           num6[111:84] = num6_4;
           num7[111:84] = num7_4;
           num8[111:84] = num8_4;
           num9[111:84] = num9_4;
           end
        5: begin
           num0[111:84] = num0_5;
           num1[111:84] = num1_5;
           num2[111:84] = num2_5;
           num3[111:84] = num3_5;
           num4[111:84] = num4_5;
           num5[111:84] = num5_5;
           num6[111:84] = num6_5;
           num7[111:84] = num7_5;
           num8[111:84] = num8_5;
           num9[111:84] = num9_5;
           end
        6: begin
           num0[111:84] = num0_6;
           num1[111:84] = num1_6;
           num2[111:84] = num2_6;
           num3[111:84] = num3_6;
           num4[111:84] = num4_6;
           num5[111:84] = num5_6;
           num6[111:84] = num6_6;
           num7[111:84] = num7_6;
           num8[111:84] = num8_6;
           num9[111:84] = num9_6;
           end
        7: begin
           num0[111:84] = num0_7;
           num1[111:84] = num1_7;
           num2[111:84] = num2_7;
           num3[111:84] = num3_7;
           num4[111:84] = num4_7;
           num5[111:84] = num5_7;
           num6[111:84] = num6_7;
           num7[111:84] = num7_7;
           num8[111:84] = num8_7;
           num9[111:84] = num9_7;
           end
        8: begin
           num0[111:84] = num0_8;
           num1[111:84] = num1_8;
           num2[111:84] = num2_8;
           num3[111:84] = num3_8;
           num4[111:84] = num4_8;
           num5[111:84] = num5_8;
           num6[111:84] = num6_8;
           num7[111:84] = num7_8;
           num8[111:84] = num8_8;
           num9[111:84] = num9_8;
           end
        9: begin
           num0[111:84] = num0_9;
           num1[111:84] = num1_9;
           num2[111:84] = num2_9;
           num3[111:84] = num3_9;
           num4[111:84] = num4_9;
           num5[111:84] = num5_9;
           num6[111:84] = num6_9;
           num7[111:84] = num7_9;
           num8[111:84] = num8_9;
           num9[111:84] = num9_9;
           end
    endcase
    
    case((score/1000)%10)
        0: begin
           num0[75:48] = num0_0;
           num1[75:48] = num1_0;
           num2[75:48] = num2_0;
           num3[75:48] = num3_0;
           num4[75:48] = num4_0;
           num5[75:48] = num5_0;
           num6[75:48] = num6_0;
           num7[75:48] = num7_0;
           num8[75:48] = num8_0;
           num9[75:48] = num9_0;
           end
           
        1: begin
           num0[75:48] = num0_1;
           num1[75:48] = num1_1;
           num2[75:48] = num2_1;
           num3[75:48] = num3_1;
           num4[75:48] = num4_1;
           num5[75:48] = num5_1;
           num6[75:48] = num6_1;
           num7[75:48] = num7_1;
           num8[75:48] = num8_1;
           num9[75:48] = num9_1;
           end
        2: begin
           num0[75:48] = num0_2;
           num1[75:48] = num1_2;
           num2[75:48] = num2_2;
           num3[75:48] = num3_2;
           num4[75:48] = num4_2;
           num5[75:48] = num5_2;
           num6[75:48] = num6_2;
           num7[75:48] = num7_2;
           num8[75:48] = num8_2;
           num9[75:48] = num9_2;
           end
        3: begin
           num0[75:48] = num0_3;
           num1[75:48] = num1_3;
           num2[75:48] = num2_3;
           num3[75:48] = num3_3;
           num4[75:48] = num4_3;
           num5[75:48] = num5_3;
           num6[75:48] = num6_3;
           num7[75:48] = num7_3;
           num8[75:48] = num8_3;
           num9[75:48] = num9_3;
           end
        4: begin
           num0[75:48] = num0_4;
           num1[75:48] = num1_4;
           num2[75:48] = num2_4;
           num3[75:48] = num3_4;
           num4[75:48] = num4_4;
           num5[75:48] = num5_4;
           num6[75:48] = num6_4;
           num7[75:48] = num7_4;
           num8[75:48] = num8_4;
           num9[75:48] = num9_4;
           end
        5: begin
           num0[75:48] = num0_5;
           num1[75:48] = num1_5;
           num2[75:48] = num2_5;
           num3[75:48] = num3_5;
           num4[75:48] = num4_5;
           num5[75:48] = num5_5;
           num6[75:48] = num6_5;
           num7[75:48] = num7_5;
           num8[75:48] = num8_5;
           num9[75:48] = num9_5;
           end
        6: begin
           num0[75:48] = num0_6;
           num1[75:48] = num1_6;
           num2[75:48] = num2_6;
           num3[75:48] = num3_6;
           num4[75:48] = num4_6;
           num5[75:48] = num5_6;
           num6[75:48] = num6_6;
           num7[75:48] = num7_6;
           num8[75:48] = num8_6;
           num9[75:48] = num9_6;
           end
        7: begin
           num0[75:48] = num0_7;
           num1[75:48] = num1_7;
           num2[75:48] = num2_7;
           num3[75:48] = num3_7;
           num4[75:48] = num4_7;
           num5[75:48] = num5_7;
           num6[75:48] = num6_7;
           num7[75:48] = num7_7;
           num8[75:48] = num8_7;
           num9[75:48] = num9_7;
           end
        8: begin
           num0[75:48] = num0_8;
           num1[75:48] = num1_8;
           num2[75:48] = num2_8;
           num3[75:48] = num3_8;
           num4[75:48] = num4_8;
           num5[75:48] = num5_8;
           num6[75:48] = num6_8;
           num7[75:48] = num7_8;
           num8[75:48] = num8_8;
           num9[75:48] = num9_8;
           end
        9: begin
           num0[75:48] = num0_9;
           num1[75:48] = num1_9;
           num2[75:48] = num2_9;
           num3[75:48] = num3_9;
           num4[75:48] = num4_9;
           num5[75:48] = num5_9;
           num6[75:48] = num6_9;
           num7[75:48] = num7_9;
           num8[75:48] = num8_9;
           num9[75:48] = num9_9;
           end
    endcase
       
    case((score/10000)%10)
        0: begin
           num0[39:12] = num0_0;
           num1[39:12] = num1_0;
           num2[39:12] = num2_0;
           num3[39:12] = num3_0;
           num4[39:12] = num4_0;
           num5[39:12] = num5_0;
           num6[39:12] = num6_0;
           num7[39:12] = num7_0;
           num8[39:12] = num8_0;
           num9[39:12] = num9_0;
           end
        1: begin
           num0[39:12] = num0_1;
           num1[39:12] = num1_1;
           num2[39:12] = num2_1;
           num3[39:12] = num3_1;
           num4[39:12] = num4_1;
           num5[39:12] = num5_1;
           num6[39:12] = num6_1;
           num7[39:12] = num7_1;
           num8[39:12] = num8_1;
           num9[39:12] = num9_1;
           end
        2: begin
           num0[39:12] = num0_2;
           num1[39:12] = num1_2;
           num2[39:12] = num2_2;
           num3[39:12] = num3_2;
           num4[39:12] = num4_2;
           num5[39:12] = num5_2;
           num6[39:12] = num6_2;
           num7[39:12] = num7_2;
           num8[39:12] = num8_2;
           num9[39:12] = num9_2;
           end
        3: begin
           num0[39:12] = num0_3;
           num1[39:12] = num1_3;
           num2[39:12] = num2_3;
           num3[39:12] = num3_3;
           num4[39:12] = num4_3;
           num5[39:12] = num5_3;
           num6[39:12] = num6_3;
           num7[39:12] = num7_3;
           num8[39:12] = num8_3;
           num9[39:12] = num9_3;
           end
        4: begin
           num0[39:12] = num0_4;
           num1[39:12] = num1_4;
           num2[39:12] = num2_4;
           num3[39:12] = num3_4;
           num4[39:12] = num4_4;
           num5[39:12] = num5_4;
           num6[39:12] = num6_4;
           num7[39:12] = num7_4;
           num8[39:12] = num8_4;
           num9[39:12] = num9_4;
           end
        5: begin
           num0[39:12] = num0_5;
           num1[39:12] = num1_5;
           num2[39:12] = num2_5;
           num3[39:12] = num3_5;
           num4[39:12] = num4_5;
           num5[39:12] = num5_5;
           num6[39:12] = num6_5;
           num7[39:12] = num7_5;
           num8[39:12] = num8_5;
           num9[39:12] = num9_5;
           end
        6: begin
           num0[39:12] = num0_6;
           num1[39:12] = num1_6;
           num2[39:12] = num2_6;
           num3[39:12] = num3_6;
           num4[39:12] = num4_6;
           num5[39:12] = num5_6;
           num6[39:12] = num6_6;
           num7[39:12] = num7_6;
           num8[39:12] = num8_6;
           num9[39:12] = num9_6;
           end
        7: begin
           num0[39:12] = num0_7;
           num1[39:12] = num1_7;
           num2[39:12] = num2_7;
           num3[39:12] = num3_7;
           num4[39:12] = num4_7;
           num5[39:12] = num5_7;
           num6[39:12] = num6_7;
           num7[39:12] = num7_7;
           num8[39:12] = num8_7;
           num9[39:12] = num9_7;
           end
        8: begin
           num0[39:12] = num0_8;
           num1[39:12] = num1_8;
           num2[39:12] = num2_8;
           num3[39:12] = num3_8;
           num4[39:12] = num4_8;
           num5[39:12] = num5_8;
           num6[39:12] = num6_8;
           num7[39:12] = num7_8;
           num8[39:12] = num8_8;
           num9[39:12] = num9_8;
           end
        9: begin
           num0[39:12] = num0_9;
           num1[39:12] = num1_9;
           num2[39:12] = num2_9;
           num3[39:12] = num3_9;
           num4[39:12] = num4_9;
           num5[39:12] = num5_9;
           num6[39:12] = num6_9;
           num7[39:12] = num7_9;
           num8[39:12] = num8_9;
           num9[39:12] = num9_9;
           end
    endcase
end  
endmodule

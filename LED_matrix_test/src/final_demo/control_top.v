`include "outputPenel.v"
`include "shift.v"
`include "drawNode.v"
`include "clk_div.v"
`include "buton_judge.v"
`include "Score.v"


module control(
    input clk,
    input rst,
    //input bottom,
    input red_button,
    input blue_button,
    input yellow_button,
    output A, 
    output B,
    output C,
    output D,
    output R0,
    output G0,
    output B0,
    output R1,
    output G1,
    output B1,
    output OE,
    output LAT,
    output clk_shft
);
    
    //wire for shift 
    wire [1:0]  song_conform;
    wire [9:0]  note_R;
    wire [9:0]  note_B;
    wire [2:0]  offset;
    wire        note_R_judge;
    wire        note_B_judge;
    wire [7:0]  combo;
    wire        finish;

    //wire for draw node 
    wire [191:0] bitmap0;
    wire [191:0] bitmap1;
    wire [191:0] bitmap2;
    wire [191:0] bitmap3;
    wire [191:0] bitmap4;
    wire [191:0] bitmap5;
    wire [191:0] bitmap6;

    //wire for matrix (Maps are the output of the draw score module)
    wire [6143:0] menuMap;
    wire [191:0]  scoreMap0;
    wire [191:0]  scoreMap1;
    wire [191:0]  scoreMap2;
    wire [191:0]  scoreMap3;
    wire [191:0]  scoreMap4;
    wire [191:0]  scoreMap5;
    wire [191:0]  scoreMap6;
    wire [191:0]  scoreMap7;
    wire [191:0]  scoreMap8;
    wire [191:0]  scoreMap9;

    //wire for button judge
    wire       delete;
    wire [1:0] score_add;

    //wire for score
    wire [15:0] score;



/*=========================================================================================================*/
    reg  [1:0] song_select;
    reg  [1:0] state;
    reg  [1:0] CS, NS;


    assign song_confirm = (yellow_button)? song_select : 2'd0;

    always @(posedge clk or posedge rst) begin
        if(rst) song_select = 1'd0;

        else if(NS == MENU) begin
            if(red_button == 1'd1  && (song_select == 2'd1) == 1'd1) song_select = 2'd3

            else if(red_button == 1'd1) song_select = song_select - 2'd1;
   
            else if(blue_button == 1'd1 && (song_select == 2'd3) == 1'd1) song_select =2'd1;

            else if(blue_button == 1'd1)  song_select = song_select + 2'd1;         
            
            else    song_select = song_select;
        end

        else        song_select = song_select;
    end

    parameter START = 2'd0, MENU = 2'd1, PLAY = 2'd2, FINISH = 2'd3;

    always @(posedge clk or posedge rst) begin
        if(rst) CS <= START;
        else    CS <= NS; 
    end

    always @(*) begin
        case(CS)

        START:  NS = ((red_button || blue_button) == 1'd1) ? MENU : START;
        
        MENU:   NS = (yellow_button == 1'd1 && (song_select != 2'd0)) ? PLAY : MENU;

        PLAY:   NS = (finish == 1'd1) ? FINISH : PLAY;

        FINISH: NS = (yellow_button == 1'd1) ? MENU : FINISH;

        endcase

    end

    always @(posedge clk or posedge rst) begin
        if(rst) state <= START;
        else    state <= NS;
    end


/*=========================================submodule=====================================*/

    clk_div clk_div_0(
        .clk(clk),
        .rst(rst),
        .clk_div(clk_shft)
    );

    shift_load SH1(
        .clk(clk_shft),
        .rst(rst),
        .yellow_button(yellow_button),
        .song(song_confirm),
        .delete(delete)        
        .note_R(note_R),
        .note_B(note_B),
        .offset(offset),
        .note_R_judge(note_R_judge),   
        .note_B_judge(note_B_judge),   
        .finish(finish)
        );

    drawNode DN1(
        .red_notes(note_R),
        .blue_notes(note_B),
        .rst(rst),
        .offset(offset),
        .bitmap0(bitmap0),
        .bitmap1(bitmap1),
        .bitmap2(bitmap2),
        .bitmap3(bitmap3),
        .bitmap4(bitmap4),
        .bitmap5(bitmap5),
        .bitmap6(bitmap6)
    );

    matrix M1(
        .clk(clk_shft),
        .rst(rst),
        .state(state),
        .menuMap(0),                //undone
        .scoreMap0(scoreMap0),
        .scoreMap1(scoreMap1),
        .scoreMap2(scoreMap2),
        .scoreMap3(scoreMap3),
        .scoreMap4(scoreMap4),
        .scoreMap5(scoreMap5),
        .scoreMap6(scoreMap6),
        .scoreMap7(scoreMap7),
        .scoreMap8(scoreMap8),
        .scoreMap9(scoreMap9),
        .notesMap0(bitmap0),
        .notesMap1(bitmap1),
        .notesMap2(bitmap2),
        .notesMap3(bitmap3),
        .notesMap4(bitmap4),
        .notesMap5(bitmap5),
        .notesMap6(bitmap6),
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



    button_judge BJ1(
        .clk(clk),
        .rst(rst),
        .red_button(red_button),
        .blue_button(blue_button),
        .offset(offset),
        .node_R(note_R_judge),
        .node_B(note_B_judge),
        .delete_red_node(delete),    //need to fix
        .score(score_add)
    );

    score SC1(
        .clk(clk),
        .reset(rst),
        .combo(combo),
        .Inp(score_add),
        .score(score)
    );

    draw_score DS1(
        .score(score),
        .num0(notesMap0),
        .num1(notesMap1),
        .num2(notesMap2),
        .num3(notesMap3),
        .num4(notesMap4),
        .num5(notesMap5),
        .num6(notesMap6),
        .num7(notesMap7),
        .num8(notesMap8),
        .num9(notesMap9)
    );


endmodule
module shift_load (
	input            clk,
	input            rst,
	input            yellow_button,  
	input      [1:0] song,      // song selection
	input            delete,
	output reg [9:0] note_R,
	//output reg [9:0] note_G,
	output reg [9:0] note_B,
	output reg [2:0] offset,    // pixel counter
	output reg     	 note_R_judge,
	output reg       note_B_judge,
	output reg [7:0] combo,     // unuse
	output reg       finish 	// the idication of song end
);

	localparam Rick_Roll = 278'b01000000010100001000001000010010000100001001001000000000000101010010000010100001000000010010000000000000000000000000001001010010100100001001000100010010001000100001000010100001001000010010100100010000100100100100000100010010000100010010000000010100010100100100000000000000000000;
	localparam yare_yare = 500'b01000100100000000100100001000000010000100100010001000000000000001000100001000000100001001000000010000001010010000100000000000000010010000100000010000100010000000100001010000100100000000000000010000100100000000100100001000000010000010100100010001000010000001000000100001000010000100000010001000010000001000100001000000100100000010000100010000001000001000100000101000100100010001000000010000010000001000100001000000100010000100000010010000001000010001000000100000100010000100000010000000000000000000000;
	localparam madeo     = 1556'b10000000000001001000000000000000100010000000010001000000000000000100000000001000010000000000000010001000000010000100000000000000010000000000100001000000000000001000010000000100100000000000000001000000000001001000000000000000010010000000010010000000000000000100000010001000010000001000010001000100000001001000000000000000010000001000010010000000100010000100100000000100010000000000000001000000100001001000000001000100100010000000010001000000100000001000000001000100100000001000010001000100000010001000000001000000010000000100010001000000100001000100100000001000010000000100100001000000100001001000000010001000010010000000010010000000010010001000000010000100100000000100100001000100000010001000000001001000100000000100010001000000100001001000010101001010101010000100000010000000010010000100000010000100100010000000010010000000100001000100000010001000010000000100100001001000000001000100000001001000100000000100100010000000010001000100010000000100100000000100100001000000100001001000000001000100010010011000101010001001100001001000010000001000100000000100000001000100000010000100000001000000100001000000100001000000100000000100100000000100100000000100000001001000000010000100000010000000010001000000010001000000100000000100100000001000100000000100000001000110010001010101100001000000100000000100100001000000100010000100100000000100100000001000100001000000010010001000000001000100010010000000010010000000010010000100000010001000010000001000100001000100000010000100000001001000010000000100010010000000100010000100100101001000010100101000000000000000000000000000;
	//localparam madeo     = 22'b0100000000000000000000;

	localparam Rick_Roll_length = 11'd278;
	localparam yare_yare_length = 11'd500;
	localparam madeo_length     = 11'd1556;
	localparam Rick_Roll_speed  = 17'd29999;
	localparam yare_yare_speed  = 17'd22999;
	localparam madeo_speed      = 17'd24999;

	integer i;

	localparam IDLE = 3'd0, NOTE_GET = 3'd1, OFFSET = 3'd2, FINISH = 3'd3;

	reg [9:0]   index;           // offset counter
	reg [1:0]   CS, NS;  
	reg [2000:0] song_bits;      // storage the selection song bits
	reg [10:0]  song_length;
	reg [16:0]  cnt_time;        // time counter
	reg [19:0]  note_range;
	reg [16:0]  speed;      


	always @(posedge clk or posedge rst) begin
		if(rst) CS <= IDLE;
		else    CS <= NS;
	end

	always @(posedge clk or posedge rst) begin
		if(rst) begin 
			song_bits   <= 2001'd0;
			song_length <= 11'd0;
			speed       <= 17'd0;
		end

		else if(CS == FINISH) begin
			song_bits   <= 2001'd0;
			song_length <= 11'd0;
			speed       <= 17'd0;
		end
		
		case(song)

		2'd1: begin
			song_bits[2000 -: Rick_Roll_length] <= Rick_Roll;
			song_length <= Rick_Roll_length;
			speed       <= Rick_Roll_speed;
		end

		2'd2: begin
			song_bits[2000 -: yare_yare_length] <= yare_yare;
		 	song_length <= yare_yare_length;
			speed       <= yare_yare_speed;
		 end

	 	 2'd3: begin
		 	song_bits[2000 -: madeo_length] <= madeo;
		 	song_length <= madeo_length;
			speed       <= madeo_speed;
		 end

		endcase

	end

	always @(*) begin
		case(CS)

		IDLE:	  NS = (song != 2'd0) 		  ? NOTE_GET : IDLE;

		NOTE_GET: NS = (cnt_time == speed)	  ? OFFSET   : NOTE_GET;

		OFFSET:   NS = (index == song_length >> 1) ? FINISH   : NOTE_GET;

		FINISH:   NS = (yellow_button == 1'd1) ? IDLE : FINISH;

		default:  NS = IDLE;

		endcase
	end


// cnt_time
	always @(posedge clk or posedge rst) begin
		if(rst) cnt_time <= 17'd0; 
		else if(CS == NOTE_GET)       cnt_time <= cnt_time + 17'd1;
		else if(cnt_time > speed)     cnt_time <= 17'd0;
		else if(CS ==FINISH) 		  cnt_time <= 17'd0;
		else                          cnt_time <= cnt_time;
	end

// offset & index
	always @(posedge clk or posedge rst) begin
		if(rst) begin 
			offset <= 3'd0;
			index  <= 10'd0;
		end
		else if(NS == OFFSET && offset == 3'd6) begin
			offset <= 3'd0;
			index <= index + 10'd1;
		end

		else if(NS == OFFSET) begin
			offset <= offset + 3'd1;
		end

		else if(CS == FINISH) begin
			index <= 10'd0;
		end

		else begin
			offset <= offset;
			index <= index;
		end
	end

// note range
	always @(posedge clk or posedge rst) begin
		if(rst) 				note_range <= 20'd0;
		else if(delete) 		note_range <= {note_range[19:18],2'd0,note_range[15:0]};
		else if(NS == OFFSET && offset == 3'd6) note_range <= {note_range[17:0], song_bits[2000-2*index-:2]};
		else if(CS == IDLE)   note_range <= 20'd0;
		else 					note_range <= note_range;
	end

	always @(posedge clk or posedge rst) begin
		if(rst) combo <= 8'd0;
		else if(delete == 1'd1) combo <= combo + 8'd1;
		else if(delete == 1'd0 && (note_range[19] || note_range[18]) == 1'd1) combo <= 8'd0;
		else if(CS == IDLE)   combo <= 8'd0;
	end


	always @(*) begin
		if(rst) begin
			note_R = 10'd0;
		  //note_G = 10'd0;
			note_B = 10'd0;
		end  
		else begin
			
				
			for ( i=0 ; i<10;i=i+1 ) begin
				if(note_range[19-i*2-:2] == 2'd1) begin
					note_R[i] = 1'd1;
					//note_G[i] = 1'd0;
					note_B[i] = 1'd0;
				end	
				else if(note_range[19-i*2-:2] == 2'd2) begin
					note_R[i] = 1'd0;
					//note_G[i] = 1'd1;
					note_B[i] = 1'd1;
				end	 
				else if(note_range[19-i*2-:2] == 2'd0)begin
						note_R[i] = 1'd0;
						//note_G[i] = 1'd1;
						note_B[i] = 1'd0;
				end					
			end
			note_B_judge = note_B[1];
			note_R_judge = note_R[1];
		end
	end



//finish
	always @(posedge clk or posedge rst) begin
		if(rst) 			  finish <= 1'd0;
		else if(NS == FINISH) finish <= 1'd1;
		else                  finish <= 1'd0;
	end

endmodule
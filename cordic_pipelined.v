
// look up table used to find angle in radians for comparison with the achieved angle
`include "lut.v"
// 2's complement block used for sine angle calculation as this cordic algo works between 0 and pi/2
// and takes in angle between -pi/2 to pi/2
`include "twoscomplimentconv.v"
module cordic (
    clk,
    rst,
    in,
    sine,
    cosine
);
input clk,rst;
input signed [7:0] in;
output reg signed [7:0] sine;
output reg [7:0] cosine;


wire signed [7:0] in_pos ;
wire signed [7:0]  x;

// x wire is assigned with the complement of the input
// start of the logic for 2's complement using binary excess 1 logic if the sign bit is 1 
// when sign bit is 0 then input is passed as it is to the wire in_pos
assign x =~in;
assign in_pos[0] = in[7]&(~x[0])|(~in[7]&in[0]);
assign in_pos[1] = in[7]&(x[1]^x[0])|(~in[7]&in[1]);
assign in_pos[2] = in[7]&(x[2]^(x[1]&x[0]))|(~in[7]&in[2]);
assign in_pos[3] = in[7]&(x[3]^(x[2]&x[1]&x[0]))|(~in[7]&in[3]);
assign in_pos[4] = in[7]&(x[4]^(x[3]&x[2]&x[1]&x[0]))|(~in[7]&in[4]);
assign in_pos[5] = in[7]&(x[5]^(x[4]&x[3]&x[2]&x[1]&x[0]))|(~in[7]&in[5]);
assign in_pos[6] = in[7]&(x[6]^(x[5]&x[4]&x[3]&x[2]&x[1]&x[0]))|(~in[7]&in[6]);
assign in_pos[7] = in[7]&(x[7]^(x[6]&x[5]&x[4]&x[3]&x[2]&x[1]&x[0]))|(~in[7]&in[7]);
    // end of 2's complement logic

    // First Cycle variables defined below:

    reg signed [13:0] x0a; // x0a holds the initial cosine value for the initial diff0
    reg signed  [13:0] x0b;  // x0a holds the initial sine value for the initial diff_cosine0
    reg signed  [13:0] y0a; // y0a holds the initial sine value for the initial diff0
    reg signed  [13:0] y0b; // y0b holds the initial cosine value for the initial diff_cosine0
    reg signed  [13:0] diff0; //starting difference between the initial angle and angle to be achieved
    reg signed  [13:0] diff_cosine0; // starting difference between (pi/2 - initial angle) and the angle to be achieved

    // thus x variable with suffix a ie. x0a,x1a,x2a etc will provide cosine angle value with good accuracy
    // and x variable with suffix b  ie. x0b,x1b,x2b etc will provide sine angle value with good accuracy
    // diff wirh suffix 0,1,2 ie. diff0 ,diff1,diff2 etc are the difference between the final angle and the achieved angle.
    // diff_cosine with suffix 0,1,2 ie. diff_cosine0,diff_cosine1 etc are the difference between the final angle and (pi/2 - the achieved angle)

    
    // Second Cycle variables defined below:
reg signed [13:0] x1a;
reg signed  [13:0] x1b;
reg signed  [13:0] y1a;
reg signed  [13:0] y1b;
reg signed  [13:0] diff1;
reg signed  [13:0] diff_cosine1;

    // Third Cycle variables defined below:
reg signed [13:0] x2a;
reg signed  [13:0] x2b;
reg signed  [13:0] y2a;
reg signed  [13:0] y2b;
reg signed  [13:0] diff2;
reg signed  [13:0] diff_cosine2;

    // Fourth Cycle variables defined below:

reg signed  [13:0] x3a;
reg signed  [13:0] x3b;
reg signed  [13:0] y3a;
reg signed  [13:0] y3b;
reg signed  [13:0] diff3;
reg signed  [13:0] diff_cosine3;

    // Fifth Cycle variables defined below:
reg signed  [13:0] x4a;
reg signed  [13:0] x4b;
reg signed  [13:0] y4a;
reg signed  [13:0] y4b;
reg signed  [13:0] diff4;
reg signed  [13:0] diff_cosine4;

        // Sixth Cycle variables defined below:
reg signed [13:0] x5a;
reg signed  [13:0] x5b;
reg signed  [13:0] y5a;
reg signed  [13:0] y5b;
reg signed  [13:0] diff5;
reg signed  [13:0] diff_cosine5;

        // Seventh Cycle variables defined below:
reg signed   [13:0] x6a;
reg signed   [13:0] x6b;
reg signed   [13:0] y6a;
reg signed   [13:0] y6b;
reg signed   [13:0] diff6;
reg signed   [13:0] diff_cosine6;

    // Eighth Cycle variables defined below:
reg signed    [13:0] x7a;
reg signed    [13:0] x7b;
reg signed    [13:0] y7a;
reg signed    [13:0] y7b;
reg signed    [13:0] diff7;
reg signed    [13:0] diff_cosine7;

    // Ninth Cycle variables defined below:
reg signed    [13:0] x8a;
reg signed    [13:0] x8b;
reg signed    [13:0] y8a;
reg signed    [13:0] y8b;
reg signed    [13:0] diff8;
reg signed    [13:0] diff_cosine8;

     // Tenth Cycle variables defined below:
reg signed    [13:0] x9a;
reg signed    [13:0] x9b;
reg signed    [13:0] y9a;
reg signed    [13:0] y9b;
reg signed    [13:0] diff9;
reg signed    [13:0] diff_cosine9;

     // Eleventh Cycle variables defined below:
reg signed    [13:0] x10a;
reg signed    [13:0] x10b;
reg signed    [13:0] y10a;
reg signed    [13:0] y10b;
reg signed    [13:0] diff10;
reg signed    [13:0] diff_cosine10;

     // twelfth Cycle variables defined below:
reg signed    [13:0] x11a;
reg signed    [13:0] x11b;
reg signed    [13:0] y11a;
reg signed    [13:0] y11b;
reg signed    [13:0] diff11;
reg signed    [13:0] diff_cosine11;

 // thirteenth Cycle variables defined below:    
reg signed [13:0] diff12;
reg signed [13:0] diff_cosine12;
reg signed [13:0] y12a;
reg signed [13:0] y12b; 
reg signed [13:0] sine_temp;
reg signed [13:0] cosine_temp;

//lut table variable for each cycle defined below:    
wire  [13:0] lut_out0;
wire [13:0] lut_out1;
wire [13:0] lut_out2;
wire [13:0] lut_out3;
wire [13:0] lut_out4;
wire [13:0] lut_out5;
wire [13:0] lut_out6;
wire [13:0] lut_out7;
wire [13:0] lut_out8;
wire [13:0] lut_out9;
wire [13:0] lut_out10;
wire [13:0] lut_out11;


 // lut module called to get the hardcoded lut table into these lut variables   
lut lu0(.in(4'd0),.out(lut_out0));
lut lu1(.in(4'd1),.out(lut_out1));
lut lu2(.in(4'd2),.out(lut_out2));
lut lu3(.in(4'd3),.out(lut_out3));
lut lu4(.in(4'd4),.out(lut_out4));
lut lu5(.in(4'd5),.out(lut_out5));
lut lu6(.in(4'd6),.out(lut_out6));
lut lu7(.in(4'd7),.out(lut_out7));
lut lu8(.in(4'd8),.out(lut_out8));
lut lu9(.in(4'd9),.out(lut_out9));
lut lu10(.in(4'd10),.out(lut_out10));
lut lu11(.in(4'd11),.out(lut_out11));

    
//flag variables used to propagate the sign bit of input angle to 
    //prevent it from getting erased by different input due to pipelining operation
reg flag0;
reg flag1;
reg flag2;
reg flag3;
reg flag4;
reg flag5;
reg flag6;
reg flag7;
reg flag8;
reg flag9;
reg flag10;
reg flag11;
reg flag12;

    //  first cycle variables getting assigned and compared with entered angle
always @(posedge clk)begin
    diff0 <= {in_pos,6'b000000}; // initial entered angle
    diff_cosine0 <= 14'b01_100100100010 - {in_pos,6'b000000}; // pi/2 - initial entered angle 
    x0a <= 14'b0_1001101101111;  // 0.6072 in base 2 
    y0a <= 14'b0_0000000000000; // 0 value
    x0b <= 14'b0_1001101101111; //0.6072 in base 2
    y0b <= 14'b0_0000000000000; // 0 in base 2
    flag0<=in[7]; // input sign bit stored in flag bit and propagated
    flag1<=flag0;
    flag2<=flag1;
    flag3<=flag2;
    flag4<=flag3;
    flag5<=flag4;
    flag6<=flag5;
    flag7<=flag6;
    flag8<=flag7;
    flag9<=flag8;
    flag10<=flag9;
    flag11<=flag10;
    flag12<=flag11;

            begin
                case (diff0[13])
                1'b1: begin
                    // -pi/4 degree rotation operation
                    // next cycle variables getting updated by shifting by -pi/4
                    
                    x1a <= x0a + (y0a >>> 0); // arithmetic sign shift operation
                    y1a <= y0a - (x0a >>> 0);

                    // updating diff between 2 angles after rotation by -pi/4 angle.
                    diff1 <= diff0 + lut_out0;
                end
                1'b0: begin
                     // pi/4 degree rotation operation
                    // next cycle variables getting updated by shifting by pi/4
                    x1a <= x0a - (y0a >>> 0);
                    y1a <= y0a + (x0a >>> 0);
                    
                    // updating diff between 2 angles after rotation by pi/4 angle.
                    diff1 <= diff0 - lut_out0;
                end
                endcase
            end
            begin
                case (diff_cosine0[13])
                1'b1: begin
                    // pi/4 degree rotation operation
                    // next cycle variables getting updated by shifting by -pi/4 
                    x1b <= x0b + (y0b >>> 0);
                    y1b <= y0b - (x0b >>> 0);
                    
                    // updating diff between 2 angles after rotation by -pi/4 angle.
                    diff_cosine1 <= diff_cosine0 + lut_out0;
                end
                1'b0: begin
                    x1b <= x0b - (y0b >>> 0);
                    y1b <= y0b + (x0b >>> 0);
                    
                    diff_cosine1 <= diff_cosine0 - lut_out0;
                end
                endcase
            end
end



//pipe_latch stage_0_to_1(.xda(x0a), .xdb(x0b), .yda(y0a), .ydb(y0b), .diffd(diff0), .diff_cosined(diff_cosine0), .xqa(x1a), .xqb(x1b), .yqa(y1a), .yqb(y1b), .diffq(diff1), .diff_cosineq(diff_cosine1));
//stage1
//count=1
always @(posedge clk)begin
            begin
                case (diff1[13])
                1'b1: begin
                    x2a <= x1a + (y1a >>> 1);
                    y2a <= y1a - (x1a >>> 1);
                    
                    diff2 <= diff1 + lut_out1;
                end
                1'b0: begin
                    x2a <= x1a - (y1a >>> 1);
                    y2a <= y1a + (x1a >>> 1);
                    
                    diff2 <= diff1 - lut_out1;
                end
                endcase
            end
            begin
                case (diff_cosine1[13])
                1'b1: begin
                    x2b <= x1b + (y1b >>> 1);
                    y2b <= y1b - (x1b >>> 1);
                    
                    diff_cosine2 <= diff_cosine1 + lut_out1;
                end
                1'b0: begin
                    x2b <= x1b - (y1b >>> 1);
                    y2b <= y1b + (x1b >>> 1);
                    
                    diff_cosine2 <= diff_cosine1 - lut_out1;
                end
                endcase
            end
end



//pipe_latch stage_1_to_2(.xda(x1a), .xdb(x1b), .yda(y1a), .ydb(y1b), .diffd(diff1), .diff_cosined(diff_cosine1), .xqa(x2a), .xqb(x2b), .yqa(y2a), .yqb(y2b), .diffq(diff2), .diff_cosineq(diff_cosine2));
//stage2
//count=2
always @(posedge clk)begin
            begin
                case (diff2[13])
                1'b1: begin
                    x3a <= x2a + (y2a >>> 2);
                    y3a <= y2a - (x2a >>> 2);
                    
                    diff3 <= diff2 + lut_out2;
                end
                1'b0: begin
                    x3a <= x2a - (y2a >>> 2);
                    y3a <= y2a + (x2a >>> 2);
                    
                    diff3 <= diff2 - lut_out2;
                end
                endcase
            end
            begin
                case (diff_cosine2[13])
                1'b1: begin
                    x3b <= x2b + (y2b >>> 2);
                    y3b <= y2b - (x2b >>> 2);
                    
                    diff_cosine3 <= diff_cosine2 + lut_out2;
                end
                1'b0: begin
                    x3b <= x2b - (y2b >>> 2);
                    y3b <= y2b + (x2b >>> 2);
                    
                    diff_cosine3 <= diff_cosine2 - lut_out2;
                end
                endcase
            end
end




//pipe_latch stage_2_to_3(.xda(x2a), .xdb(x2b), .yda(y2a), .ydb(y2b), .diffd(diff2), .diff_cosined(diff_cosine2), .xqa(x3a), .xqb(x3b), .yqa(y3a), .yqb(y3b), .diffq(diff3), .diff_cosineq(diff_cosine3));
//stage3
//count=3
always @(posedge clk)begin
            begin
                case (diff3[13])
                1'b1: begin
                    x4a <= x3a + (y3a >>> 3);
                    y4a <= y3a - (x3a >>> 3);
                    
                    diff4 <= diff3 + lut_out3;
                end
                1'b0: begin
                    x4a <= x3a - (y3a >>> 3);
                    y4a <= y3a + (x3a >>> 3);
                    
                    diff4 <= diff3 - lut_out3;
                end
                endcase
            end
            begin
                case (diff_cosine3[13])
                1'b1: begin
                    x4b <= x3b + (y3b >>> 3);
                    y4b <= y3b - (x3b >>> 3);
                    
                    diff_cosine4 <= diff_cosine3 + lut_out3;
                end
                1'b0: begin
                    x4b <= x3b - (y3b >>> 3);
                    y4b <= y3b + (x3b >>> 3);
                    
                    diff_cosine4 <= diff_cosine3 - lut_out3;
                end
                endcase
            end
end



//pipe_latch stage_3_to_4(.xda(x3a), .xdb(x3b), .yda(y3a), .ydb(y3b), .diffd(diff3), .diff_cosined(diff_cosine3), .xqa(x4a), .xqb(x4b), .yqa(y4a), .yqb(y4b), .diffq(diff4), .diff_cosineq(diff_cosine4));
//stage4
//count=4
always @(posedge clk)begin
            begin
                case (diff4[13])
                1'b1: begin
                    x5a <= x4a + (y4a >>> 4);
                    y5a <= y4a - (x4a >>> 4);
                    
                    diff5 <= diff4 + lut_out4;
                end
                1'b0: begin
                    x5a <= x4a - (y4a >>> 4);
                    y5a <= y4a + (x4a >>> 4);
                    
                    diff5 <= diff4 - lut_out4;
                end
                endcase
            end
            begin
                case (diff_cosine4[13])
                1'b1: begin
                    x5b <= x4b + (y4b >>> 4);
                    y5b <= y4b - (x4b >>> 4);
                    
                    diff_cosine5 <= diff_cosine4 + lut_out4;
                end
                1'b0: begin
                    x5b <= x4b - (y4b >>> 4);
                    y5b <= y4b + (x4b >>> 4);
                    
                    diff_cosine5 <= diff_cosine4 - lut_out4;
                end
                endcase
            end
end

//pipe_latch stage_4_to_5(.xda(x4a), .xdb(x4b), .yda(y4a), .ydb(y4b), .diffd(diff4), .diff_cosined(diff_cosine4), .xqa(x5a), .xqb(x5b), .yqa(y5a), .yqb(y5b), .diffq(diff5), .diff_cosineq(diff_cosine5));
//stage5
//count=5
always @(posedge clk)begin
            begin
                case (diff5[13])
                1'b1: begin
                    x6a <= x5a + (y5a >>> 5);
                    y6a <= y5a - (x5a >>> 5);
                    
                    diff6 <= diff5 + lut_out5;
                end
                1'b0: begin
                    x6a <= x5a - (y5a >>> 5);
                    y6a <= y5a + (x5a >>> 5);
                    
                    diff6 <= diff5 - lut_out5;
                end
                endcase
            end
            begin
                case (diff_cosine5[13])
                1'b1: begin
                    x6b <= x5b + (y5b >>> 5);
                    y6b <= y5b - (x5b >>> 5);
                    
                    diff_cosine6 <= diff_cosine5 + lut_out5;
                end
                1'b0: begin
                    x6b <= x5b - (y5b >>> 5);
                    y6b <= y5b + (x5b >>> 5);
                    
                    diff_cosine6 <= diff_cosine5 - lut_out5;
                end
                endcase
            end
end



//pipe_latch stage_5_to_6(.xda(x5a), .xdb(x5b), .yda(y5a), .ydb(y5b), .diffd(diff5), .diff_cosined(diff_cosine5), .xqa(x6a), .xqb(x6b), .yqa(y6a), .yqb(y6b), .diffq(diff6), .diff_cosineq(diff_cosine6));
//stage6
//count=6
always @(posedge clk)begin
            begin
                case (diff6[13])
                1'b1: begin
                    x7a <= x6a + (y6a >>> 6);
                    y7a <= y6a - (x6a >>> 6);
                    
                    diff7 <= diff6 + lut_out6;
                end
                1'b0: begin
                    x7a <= x6a - (y6a >>> 6);
                    y7a <= y6a + (x6a >>> 6);
                    
                    diff7 <= diff6 - lut_out6;
                end
                endcase
            end
            begin
                case (diff_cosine6[13])
                1'b1: begin
                    x7b <= x6b + (y6b >>> 6);
                    y7b <= y6b - (x6b >>> 6);
                    
                    diff_cosine7 <= diff_cosine6 + lut_out6;
                end
                1'b0: begin
                    x7b <= x6b - (y6b >>> 6);
                    y7b <= y6b + (x6b >>> 6);
                    
                    diff_cosine7 <= diff_cosine6 - lut_out6;
                end
                endcase
            end
end



//pipe_latch stage_6_to_7(.xda(x6a), .xdb(x6b), .yda(y6a), .ydb(y6b), .diffd(diff6), .diff_cosined(diff_cosine6), .xqa(x7a), .xqb(x7b), .yqa(y7a), .yqb(y7b), .diffq(diff7), .diff_cosineq(diff_cosine7));
//stage7
//count=7
always @(posedge clk)begin
            begin
                case (diff7[13])
                1'b1: begin
                    x8a <= x7a + (y7a >>> 7);
                    y8a <= y7a - (x7a >>> 7);
                    
                    diff8 <= diff7 + lut_out7;
                end
                1'b0: begin
                    x8a <= x7a - (y7a >>> 7);
                    y8a <= y7a + (x7a >>> 7);
                    
                    diff8 <= diff7 - lut_out7;
                end
                endcase
            end
            begin
                case (diff_cosine7[13])
                1'b1: begin
                    x8b <= x7b + (y7b >>> 7);
                    y8b <= y7b - (x7b >>> 7);
                    
                    diff_cosine8 <= diff_cosine7 + lut_out7;
                end
                1'b0: begin
                    x8b <= x7b - (y7b >>> 7);
                    y8b <= y7b + (x7b >>> 7);
                    
                    diff_cosine8 <= diff_cosine7 - lut_out7;
                end
                endcase
            end
end



//pipe_latch stage_7_to_8(.xda(x7a), .xdb(x7b), .yda(y7a), .ydb(y7b), .diffd(diff7), .diff_cosined(diff_cosine7), .xqa(x8a), .xqb(x8b), .yqa(y8a), .yqb(y8b), .diffq(diff8), .diff_cosineq(diff_cosine8));
//stage8
//count=8
always @(posedge clk)begin
            begin
                case (diff8[13])
                1'b1: begin
                    x9a <= x8a + (y8a >>> 8);
                    y9a <= y8a - (x8a >>> 8);
                    
                    diff9 <= diff8 + lut_out8;
                end
                1'b0: begin
                    x9a <= x8a - (y8a >>> 8);
                    y9a <= y8a + (x8a >>> 8);
                    
                    diff9 <= diff8 - lut_out8;
                end
                endcase
            end
            begin
                case (diff_cosine8[13])
                1'b1: begin
                    x9b <= x8b + (y8b >>> 8);
                    y9b <= y8b - (x8b >>> 8);
                    
                    diff_cosine9 <= diff_cosine8 + lut_out8;
                end
                1'b0: begin
                    x9b <= x8b - (y8b >>> 8);
                    y9b <= y8b + (x8b >>> 8);
                    
                    diff_cosine9 <= diff_cosine8 - lut_out8;
                end
                endcase
            end
end


//pipe_latch stage_8_to_9(.xda(x8a), .xdb(x8b), .yda(y8a), .ydb(y8b), .diffd(diff8), .diff_cosined(diff_cosine8), .xqa(x9a), .xqb(x9b), .yqa(y9a), .yqb(y9b), .diffq(diff9), .diff_cosineq(diff_cosine9));
//stage9
//count=9
always @(posedge clk)begin
            begin
                case (diff9[13])
                1'b1: begin
                    x10a <= x9a + (y9a >>> 9);
                    y10a <= y9a - (x9a >>> 9);
                    
                    diff10 <= diff9 + lut_out9;
                end
                1'b0: begin
                    x10a <= x9a - (y9a >>> 9);
                    y10a <= y9a + (x9a >>> 9);
                    
                    diff10 <= diff9 - lut_out9;
                end
                endcase
            end
            begin
                case (diff_cosine9[13])
                1'b1: begin
                    x10b <= x9b + (y9b >>> 9);
                    y10b <= y9b - (x9b >>> 9);
                    
                    diff_cosine10 <= diff_cosine9 + lut_out9;
                end
                1'b0: begin
                    x10b <= x9b - (y9b >>> 9);
                    y10b <= y9b + (x9b >>> 9);
                    
                    diff_cosine10 <= diff_cosine9 - lut_out9;
                end
                endcase
            end
end


//pipe_latch stage_9_to_10(.xda(x9a), .xdb(x9b), .yda(y9a), .ydb(y9b), .diffd(diff9), .diff_cosined(diff_cosine9), .xqa(x10a), .xqb(x10b), .yqa(y10a), .yqb(y10b), .diffq(diff10), .diff_cosineq(diff_cosine10));
//stage10
//count=10
always @(posedge clk)begin
            begin
                case (diff10[13])
                1'b1: begin
                    x11a <= x10a + (y10a >>> 10);
                    y11a <= y10a - (x10a >>> 10);
                    
                    diff11 <= diff10 + lut_out10;
                end
                1'b0: begin
                    x11a <= x10a - (y10a >>> 10);
                    y11a <= y10a + (x10a >>> 10);
                    
                    diff11 <= diff10 - lut_out10;
                end
                endcase
            end
            begin
                case (diff_cosine10[13])
                1'b1: begin
                    x11b <= x10b + (y10b >>> 10);
                    y11b <= y10b - (x10b >>> 10);
                    
                    diff_cosine11 <= diff_cosine10 + lut_out10;
                end
                1'b0: begin
                    x11b <= x10b - (y10b >>> 10);
                    y11b <= y10b + (x10b >>> 10);
                    
                    diff_cosine11 <= diff_cosine10 - lut_out10;
                end
                endcase
            end
end



//pipe_latch stage_10_to_11(.xda(x10a), .xdb(x10b), .yda(y10a), .ydb(y10b), .diffd(diff10), .diff_cosined(diff_cosine10), .xqa(x11a), .xqb(x11b), .yqa(y11a), .yqb(y11b), .diffq(diff11), .diff_cosineq(diff_cosine11));
//stage11
//count=11
always @(posedge clk)begin
            begin
                case (diff11[13])
                1'b1: begin
                    cosine_temp <= x11a + (y11a >>> 11);
                    y12a <= y11a - (x11a >>> 11);
                    
                    diff12 <= diff11 + lut_out11;
                end
                1'b0: begin
                    cosine_temp <= x11a - (y11a >>> 11);
                    y12a <= y11a + (x11a >>> 11);
                    
                    diff12 <= diff11 - lut_out11;
                end
                endcase
            end
            begin
                case (diff_cosine11[13])
                1'b1: begin
                    sine_temp <= x11b + (y11b >>> 11);
                    y12b <= y11b - (x11b >>> 11);
                    
                    diff_cosine12 <= diff_cosine11 + lut_out11;
                end
                1'b0: begin
                    sine_temp <= x11b - (y11b >>> 11);
                    y12b <= y11b + (x11b >>> 11);
                    
                    diff_cosine12 <= diff_cosine11 - lut_out11;
                end
                endcase
            end
end
    // rounding logic is given below:
    wire [6:0] fracpart;
    wire [6:0] cosine_fracpart;
    reg  [7:0] rounded_sine;
    wire [7:0] rounded_sine1;
    reg [7:0] rounded_cosine;
    reg [7:0] rounded_cosine1;

    assign fracpart=sine_temp[12:6]+sine_temp[5];
    assign cosine_fracpart=cosine_temp[12:6]+cosine_temp[5];
    always @(posedge clk) begin
        case (sine_temp[12])
            1'b0: begin
                rounded_sine <= {sine_temp[13],fracpart};
            end
            1'b1: begin
                rounded_sine <= sine_temp[13:6];
            end
        endcase
        case (cosine_temp[12])
           1'b0 : begin
                rounded_cosine <= {cosine_temp[13],cosine_fracpart};
           end
           1'b1 : begin
                rounded_cosine <= cosine_temp[13:6];
           end
        endcase
    end

    // Depending upon the sign bit saved in the flag12, either the sine value is 2's complemented or  just passed as it is.
    wire signed [7:0]  x1;
    assign x1 =~rounded_sine;
    assign rounded_sine1[0] = flag12&(~x1[0])|(~flag12&rounded_sine[0]);
    assign rounded_sine1[1] = flag12&(x1[1]^x1[0])|(~flag12&rounded_sine[1]);
    assign rounded_sine1[2] = flag12&(x1[2]^(x1[1]&x1[0]))|(~flag12&rounded_sine[2]);
    assign rounded_sine1[3] = flag12&(x1[3]^(x1[2]&x1[1]&x1[0]))|(~flag12&rounded_sine[3]);
    assign rounded_sine1[4] = flag12&(x1[4]^(x1[3]&x1[2]&x1[1]&x1[0]))|(~flag12&rounded_sine[4]);
    assign rounded_sine1[5] = flag12&(x1[5]^(x1[4]&x1[3]&x1[2]&x1[1]&x1[0]))|(~flag12&rounded_sine[5]);
    assign rounded_sine1[6] = flag12&(x1[6]^(x1[5]&x1[4]&x1[3]&x1[2]&x1[1]&x1[0]))|(~flag12&rounded_sine[6]);
    assign rounded_sine1[7] = flag12&(x1[7]^(x1[6]&x1[5]&x1[4]&x1[3]&x1[2]&x1[1]&x1[0]))|(~flag12&rounded_sine[7]);
    always @(posedge clk ) begin
        sine<=rounded_sine1; // final pipeline for saving sine
        cosine<=rounded_cosine; // final pipeline for saving cosine
    end


endmodule

`include "lut.v"
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
    reg signed [13:0] sine_temp;
    reg signed [13:0] cosine_temp;
    wire [11:0] fracpart_tempb;
    wire [10:0] fracpart_temp0;
    wire [9:0] fracpart_temp1;
    wire [8:0] fracpart_temp2;
    wire [7:0] fracpart_temp3;
    wire [6:0] fracpart;
    output reg [7:0] cosine;
    reg signed [13:0] xa;
    reg signed [13:0] ya;
    reg signed [13:0] xb;
    reg signed [13:0] yb;
    reg signed [3:0] count; 
    wire [13:0] lut_out;
    reg signed [13:0] diff ;
    reg signed [13:0] diff_cosine;
    wire signed [7:0] in_pos ;
    wire signed [7:0]  x;
    assign x =~in;
    assign in_pos[0] = in[7]&(~x[0])|(~in[7]&in[0]);
    assign in_pos[1] = in[7]&(x[1]^x[0])|(~in[7]&in[1]);
    assign in_pos[2] = in[7]&(x[2]^(x[1]&x[0]))|(~in[7]&in[2]);
    assign in_pos[3] = in[7]&(x[3]^(x[2]&x[1]&x[0]))|(~in[7]&in[3]);
    assign in_pos[4] = in[7]&(x[4]^(x[3]&x[2]&x[1]&x[0]))|(~in[7]&in[4]);
    assign in_pos[5] = in[7]&(x[5]^(x[4]&x[3]&x[2]&x[1]&x[0]))|(~in[7]&in[5]);
    assign in_pos[6] = in[7]&(x[6]^(x[5]&x[4]&x[3]&x[2]&x[1]&x[0]))|(~in[7]&in[6]);
    assign in_pos[7] = in[7]&(x[7]^(x[6]&x[5]&x[4]&x[3]&x[2]&x[1]&x[0]))|(~in[7]&in[7]);
always @(posedge rst) begin
        cosine_temp<=14'd0;
        sine_temp<=14'd0;
        diff <= {in_pos,6'b000000}; 
        diff_cosine <= 14'b01_100100100010 - {in_pos,6'b000000};
        count <= 4'b0000;
        xa <= 14'b0_1001101101111;
        ya <= 14'b0_0000000000000;
        xb <= 14'b0_1001101101111;
        yb <= 14'b0_0000000000000;
    end
    lut lu(.in(count),.out(lut_out));
    always @(posedge clk ) begin
        count<=count+1'b1;
    end 
    always @(posedge clk ) begin
        if (count==4'b1100) begin
            cosine_temp<=xa;
            sine_temp<=xb;
            diff <= {in_pos,6'b000000}; 
            diff_cosine <= 14'b01_100100100010 - {in_pos,6'b000000};
            count <= 4'b0000;
            xa <= 14'b0_1001101101111;
            ya <= 14'b0_0000000000000;
            xb <= 14'b0_1001101101111;
            yb <= 14'b0_0000000000000;
        end
        else begin
            begin
                case (diff[13])
                1'b1: begin
                    xa <= xa + (ya >>> count);
                    ya <= ya - (xa >>> count);
                    
                    diff <= diff + lut_out;
                end
                1'b0: begin
                    xa <= xa - (ya >>> count);
                    ya <= ya + (xa >>> count);
                    
                    diff <= diff - lut_out;
                end
                endcase
            end
            begin
                case (diff_cosine[13])
                1'b1: begin
                    xb <= xb + (yb >>> count);
                    yb <= yb - (xb >>> count);
                    
                    diff_cosine <= diff_cosine + lut_out;
                end
                1'b0: begin
                    xb <= xb - (yb >>> count);
                    yb <= yb + (xb >>> count);
                    
                    diff_cosine <= diff_cosine - lut_out;
                end
                endcase
            end
        end
    end
    wire [11:0] cosine_fracpart_tempb;
    wire [10:0] cosine_fracpart_temp0;
    wire [8:0] cosine_fracpart_temp2;
    wire [9:0] cosine_fracpart_temp1;
    wire [7:0] cosine_fracpart_temp3;
    wire [6:0] cosine_fracpart;
    wire [7:0] rounded_sine;
    wire [7:0] rounded_sine1;
    wire [7:0] rounded_cosine;
    assign fracpart=sine_temp[12:6];
    assign cosine_fracpart=cosine_temp[12:6];
    assign rounded_sine = {sine_temp[13],fracpart};
    assign rounded_cosine = {cosine_temp[13],cosine_fracpart};
    wire signed [7:0]  x1;
    assign x1 =~rounded_sine;
    assign rounded_sine1[0] = in[7]&(~x1[0])|(~in[7]&rounded_sine[0]);
    assign rounded_sine1[1] = in[7]&(x1[1]^x1[0])|(~in[7]&rounded_sine[1]);
    assign rounded_sine1[2] = in[7]&(x1[2]^(x1[1]&x1[0]))|(~in[7]&rounded_sine[2]);
    assign rounded_sine1[3] = in[7]&(x1[3]^(x1[2]&x1[1]&x1[0]))|(~in[7]&rounded_sine[3]);
    assign rounded_sine1[4] = in[7]&(x1[4]^(x1[3]&x1[2]&x1[1]&x1[0]))|(~in[7]&rounded_sine[4]);
    assign rounded_sine1[5] = in[7]&(x1[5]^(x1[4]&x1[3]&x1[2]&x1[1]&x1[0]))|(~in[7]&rounded_sine[5]);
    assign rounded_sine1[6] = in[7]&(x1[6]^(x1[5]&x1[4]&x1[3]&x1[2]&x1[1]&x1[0]))|(~in[7]&rounded_sine[6]);
    assign rounded_sine1[7] = in[7]&(x1[7]^(x1[6]&x1[5]&x1[4]&x1[3]&x1[2]&x1[1]&x1[0]))|(~in[7]&rounded_sine[7]);
    always @(posedge clk ) begin
        sine<=rounded_sine1;
        cosine<=rounded_cosine;
    end
    
endmodule
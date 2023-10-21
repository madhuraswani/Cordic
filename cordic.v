`include "lut.v"
module cordic (
    clk,
    rst,
    in,
    sine,
    cosine
);
    input clk,rst;
    input [7:0] in;
    output reg [7:0] sine;
    reg [11:0] sine_temp;
    reg [11:0] cosine_temp;
    wire [8:0] fracpart_temp1;
    wire [7:0] fracpart_temp2;
    wire [6:0] fracpart_temp3;
    wire [5:0] fracpart;
    output reg [7:0] cosine;
    reg [11:0] x;
    reg [11:0] y;
    reg [3:0] count; 
    wire [11:0] lut_out;
    reg [11:0] diff ;

   always @(posedge rst) begin
        diff <= {in,4'b0000}; 
        count <= 4'b0000;
        x <= 12'b00_1001101110;
        y <= 12'b00_0000000000;
    end
    lut lu(.in(count),.out(lut_out));
    always @(posedge clk ) begin
        count<=count+1'b1;
    end 
    always @(posedge clk ) begin
        if (count==4'b1011) begin
            cosine_temp<=x;
            sine_temp<=y;
            diff <= {in,4'b0000}; 
            count <= 4'b0000;
            x <= 12'b00_1001101110;
            y <= 12'b00_0000000000;
        end
        else begin
            begin
                case (diff[11])
                1'b1: begin
                    x <= x + (y >>> count);
                    y <= y - (x >>> count);
                    diff <= diff + lut_out;
                end
                1'b0: begin
                    x <= x - (y >>> count);
                    y <= y + (x >>> count);
                    diff <= diff - lut_out;
                end
                endcase
            end
        end
    end
    wire [7:0] cosine_fracpart_temp2;
    wire [8:0] cosine_fracpart_temp1;
    wire [6:0] cosine_fracpart_temp3;
    wire [5:0] cosine_fracpart;
    assign fracpart_temp1=sine_temp[9:1]+sine_temp[0];
    assign fracpart_temp2=fracpart_temp1[8:1]+fracpart_temp1[0];
    assign fracpart_temp3=fracpart_temp2[7:1]+fracpart_temp2[0];
    assign fracpart=fracpart_temp3[6:1]+fracpart_temp3[0];
    assign cosine_fracpart_temp1=cosine_temp[9:1]+cosine_temp[0];
    assign cosine_fracpart_temp2=cosine_fracpart_temp1[8:1]+cosine_fracpart_temp1[0];
    assign cosine_fracpart_temp3=cosine_fracpart_temp2[7:1]+cosine_fracpart_temp2[0];
    assign cosine_fracpart=cosine_fracpart_temp3[6:1]+cosine_fracpart_temp3[0];
    always @(posedge clk ) begin
        sine<={sine_temp[11:10],fracpart};
        cosine<={cosine_temp[11:10],cosine_fracpart};
    end
    
endmodule
`include "cordic.v"
`default_nettype none
`timescale 1ns/1ps

module tb_cordic;

reg clk;
reg rst_n;
reg [7:0] in;
wire [7:0] cosine;
wire [7:0] sine;

localparam sf=2**-6;

cordic c
(
    .rst (rst_n),
    .clk (clk),
    .in (in),
    .sine (sine),
    .cosine (cosine)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_cordic.vcd");
    $dumpvars(0, tb_cordic);
end

initial begin
    clk =1'b0;
repeat(1200)
clk=~clk;
end

initial begin
    $monitor("Cosine: %f Sine: %f angle: %f",$itor(sine)*sf,$itor(cosine)*sf,$itor(in)*sf);
    #5 rst_n = 1'b0;
	#5 rst_n = 1'b1;
    //in=8'b00_001110;
    in=8'b00_101011;
    repeat(14) @(posedge clk);
    repeat(2) @(posedge clk);
    $finish(2);
end

endmodule
`default_nettype wire
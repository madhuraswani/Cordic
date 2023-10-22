`include "cordic_pipelined.v"
`default_nettype none
`timescale 1ns/1ns

module tb_cordic;

reg clk;
reg rst_n;
reg signed [7:0] in;
wire signed [7:0] cosine;
wire signed [7:0] sine;
time period=10;
localparam sf = 2.0 ** -6.0;
localparam o_SF = 2.0 ** -7.0;

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
    $monitor("Cycle: %t \t Cosine: %f \t Sine: %f \t angle: %f \t actual_sine: %f \t actual_cosine: %f \n \t sine_error= %f \t cos_error= %f",$time/period,$itor(cosine*o_SF),$itor(sine*o_SF),$itor(in*sf),$sin($itor(in*sf)),$cos($itor(in*sf)),($sin($itor(in*sf))-$itor(sine*o_SF)),($cos($itor(in*sf))-$itor(cosine*o_SF)));
    #5 rst_n = 1'b0;
	#5 rst_n = 1'b1;
    in=8'b00_001110;
    repeat(1) @(posedge clk);
    //in=8'b00_101011;
    //in=8'b00_101100;
    //in=8'b10_011101;
    in=8'b01_100011; //near pi/2
    repeat(1) @(posedge clk);
    in=8'b00_000000;
    repeat(1) @(posedge clk);
    in=8'b00_110010;
    repeat(1) @(posedge clk);
    in=8'b11_001110; //near -pi/2
    repeat(28) @(posedge clk);
    in=8'b11_001110;
    repeat(2) @(posedge clk);
    $finish(2);
end

endmodule
`default_nettype wire
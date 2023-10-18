`include "cordic.v"
`default_nettype none
`timescale 1ns/1ps

module tb_cordic;
reg clk;
reg rst_n;
reg [7:0] in;
wire [7:0] cosine;
wire [7:0] sine;

cordic c
(
    .rst (rst_n),
    .clk (clk),
    .in (in),
    .sine (sine)
    .cosine (cosine)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_cordic.vcd");
    $dumpvars(0, tb_cordic);
end

initial begin
    $monitor("Cosine: %f Sine: %f",$itor(sine),$itor(cosine))
    in=8'd1.483
    repeat(25) @(posedge clk);
    repeat(2) @(posedge clk);
    $finish(2);
end

endmodule
`default_nettype wire
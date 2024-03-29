`include "cordic_pipelined.v"
`default_nettype none
`timescale 1ns/1ns

module tb_cordic_csv;

integer fp;
reg clk;
reg rst_n;
reg signed [7:0] in;
wire signed [7:0] cosine;
wire signed [7:0] sine;
time period=10;
localparam sf = 2.0 ** -6.0;
localparam o_SF = 2.0 ** -7.0;
integer j;

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
    $dumpfile("tb_cordic_csv.vcd");
    $dumpvars(0, tb_cordic_csv);
end

initial begin
    clk =1'b0;
repeat(1200)
clk=~clk;
end

initial begin
    fp=$fopen("./tb_out.txt","w+");
    $fmonitor(fp,"%f,%f,%f",$itor(cosine*o_SF),$itor(sine*o_SF),$itor(in*sf));
    $monitor("%f,%f,%f",$itor(cosine*o_SF),$itor(sine*o_SF),$itor(in*sf));
    #5 rst_n = 1'b0;
	#5 rst_n = 1'b1;
    for (j = -99; j<100 ; j=j+1 ) begin
        if (j==-99) begin
            in=8'b10_011101;
        end
        else begin
            in=in+1;
            #180;
        end
    end
    $finish(2);
end

endmodule
`default_nettype wire
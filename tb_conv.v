module tb_conv;

reg flag;
reg signed [7:0] in;
wire signed [7:0] out;

converter i_converter(.flag(flag),.in(in) ,.out(out));


initial
begin
flag =1'b0;
in = 8'h05;
end

initial
begin
#5 flag=1'b1;
 		in = 8'hf5;

#5 flag=1'b0;
 		in = 8'h75;

#5 flag=1'b1;
 		in = 8'h85;

#5 flag=1'b0;
 		in = 8'h55;

#5 flag=1'b1;
 		in = 8'hb5;

#5 flag=1'b1;
 		in = 8'hf3;

#5 flag=1'b0;
 		in = 8'h79;

#5 flag=1'b1;
 		in = 8'h8f;

#5 flag=1'b0;
 		in = 8'h51;

#5 flag=1'b1;
 		in = 8'hb0;

#5 flag=1'b1;
 		in = 8'hb4;

#5 flag=1'b0;
 		in = 8'h76;

#5 flag=1'b1;
 		in = 8'he6;

	
end

initial
begin

 $monitor ("[%0t] flag=0x%0h  in=0x%0h out=0x%0h", $time,flag,in,out);
      // 3. After Step2 is over, wait for 5ns and finish simulation
      #50 $stop;
end

endmodule
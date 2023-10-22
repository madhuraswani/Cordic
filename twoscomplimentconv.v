module converter( input wire flag, input wire signed [7:0] in ,output reg signed [7:0] out);

	wire signed [7:0]  x;

assign x =~in;

always @(flag) begin
		case(flag)

			1'b0:
				begin
				
					out <= in;
		
				end

			1'b1:
				begin
				
					 out[0] = ~x[0];
					 out[1] = x[1]^x[0];
					 out[2] = x[2]^(x[1]&x[0]);
					 out[3] = x[3]^(x[2]&x[1]&x[0]);
					 out[4] = x[4]^(x[3]&x[2]&x[1]&x[0]);
					 out[5] = x[5]^(x[4]&x[3]&x[2]&x[1]&x[0]);
					 out[6] = x[6]^(x[5]&x[4]&x[3]&x[2]&x[1]&x[0]);
					 out[7] = x[7]^(x[6]&x[5]&x[4]&x[3]&x[2]&x[1]&x[0]);
		
				end
		endcase

	end

endmodule
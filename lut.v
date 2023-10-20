module lut (
    in,out
);
 input [3:0]in;

reg[11:0] lut1=12'b00_1100100100;

reg[11:0] lut2=12'b00_0111011010;

reg[11:0] lut3=12'b00_0011111010;

reg[11:0] lut4=12'b00_0001111111;

reg[11:0] lut5=12'b00_0000111111;

reg[11:0] lut6=12'b00_0000011111;

reg[11:0] lut7=12'b00_0000001111;

reg[11:0] lut8=12'b00_0000001000;

reg[11:0] lut9=12'b00_0000000100;

reg[11:0] lut10=12'b00_0000000010;
output reg [11:0] out;
 always @(in) begin
    case (in)
        4'b0000: begin
            out<=lut1;
        end
        4'b0001: begin
            out<=lut2;
        end
        4'b0010: begin
            out<=lut3;
        end
        4'b0011: begin
            out<=lut4;
        end
        4'b0100: begin
            out<=lut5;
        end
        4'b0101: begin
            out<=lut6;
        end
        4'b0110: begin
            out<=lut7;
        end
        4'b0111: begin
            out<=lut8;
        end
        4'b1000: begin
            out<=lut9;
        end
        4'b1001: begin
            out<=lut10;
        end
        default: begin
            out<=out;
        end
    endcase
 end

endmodule
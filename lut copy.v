module lut (
    in,out
);
 input [3:0]in;
//output of python code

// {1: '00_110010010000', 
// 0.5: '00_011101101010', 
// 0.25: '00_001111101011', 
// 0.125: '00_000111111101', 
// 0.0625: '00_000011111111', 
// 0.03125: '00_000001111111', 
// 0.015625: '00_000000111111', 
// 0.0078125: '00_000000011111', 
// 0.00390625: '00_000000001111', 
// 0.001953125: '00_000000001000', 
// 0.0009765625: '00_000000000100', 
// 0.00048828125: '00_000000000010'}

reg[13:0] lut1=14'b00_110010010000;

reg[13:0] lut2=14'b00_011101101010;

reg[13:0] lut3=14'b00_001111101011;

reg[13:0] lut4=14'b00_000111111101;

reg[13:0] lut5=14'b00_000011111111;

reg[13:0] lut6=14'b00_000001111111;

reg[13:0] lut7=14'b00_000000111111;

reg[13:0] lut8=14'b00_000000011111;

reg[13:0] lut9=14'b00_000000001111;

reg[13:0] lut10=14'b00_000000001000;

reg[13:0] lut11=14'b00_000000000100;

reg[13:0] lut12=14'b00_000000000010;

output reg [13:0] out;
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
        4'b1010: begin
            out<=lut11;
        end
        4'b1011: begin
            out<=lut12;
        end
        default: begin
            out<=out;
        end
    endcase
 end

endmodule
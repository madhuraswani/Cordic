module cos_lookup (
    in,out
);
    input in;
    output reg [11:0] out ;
    reg [11:0] cos_1=12'b00_1011010100 ;
    reg [11:0] cos_2=12'b00_1010000111 ;
    reg [11:0] cos_3=12'b00_1001110100 ;
    reg [11:0] cos_4=12'b00_1001101111 ;
    reg [11:0] cos_5=12'b00_1001101110 ;
    reg [11:0] cos_6=12'b00_1001101101 ;

endmodule
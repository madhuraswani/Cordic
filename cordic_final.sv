//`define synth 
module cordic # (parameter DATA_WIDTH=8)

(
    input clk, rst,
    input signed [DATA_WIDTH-1:0] angle,  // in Radians, 1 sign bit 1 integer bit 6 frac bits
    output bit signed [DATA_WIDTH-1:0] cos_val, sin_val
);

localparam MEM_SIZE=6;
localparam ITER_COUNT = 6;
//localparam [6:0] error_prec ; // 1 bit integer, 6 bits frac, no need of sign bit

// implementing LUT in registers instad of memory as per spec 
// assuming max iterations of 6 right now


//AM bit signed [DATA_WIDTH*MEM_SIZE-1:0] lut;
bit signed [DATA_WIDTH-1:0]lut[MEM_SIZE];
bit signed [DATA_WIDTH-1:0] x_2_inv;
bit [2:0] flag_count;
bit flag;

//TODO change the size of registers
//TODO change this to register logic later
bit signed [DATA_WIDTH-1:0] x[MEM_SIZE-1:0];
bit signed [DATA_WIDTH-1:0] y[MEM_SIZE-1:0];
bit signed [DATA_WIDTH-1:0] z[MEM_SIZE-1:0];

// storing tan-1 values of angles taken in radians tan-1(2**-i) 
//AM initial begin
//AM     lut[7:0]    = 00_110010; // tan-1(1)
//AM     lut[15:8]   = 00_011101; //  tan-1(1/2)
//AM     lut[23:16]  = 00_001111; // tan-1(1/4)
//AM     lut[31:24]  = 00_000111; // tan-1(1/8)
//AM     lut[39:32]  = 00_000011; // tan-1(1/16)
//AM     lut[47:40]  = 00_000001; // tan-1(1/32)
//AM end

initial begin
    lut[0]  = 'b00_110010; // tan-1(1)
    lut[1]  = 'b00_011101; //  tan-1(1/2)
    lut[2]  = 'b00_001111; // tan-1(1/4)
    lut[3]  = 'b00_000111; // tan-1(1/8)
    lut[4]  = 'b00_000011; // tan-1(1/16)
    lut[5]  = 'b00_000001; // tan-1(1/32)


end

assign flag =  (angle^ z[0])? 1'b1 : 1'b0;

//`ifndef synth 
//initial begin
//    for(int i =0; i< MEM_SIZE; i++)
//    begin
//        $display("lut[%d]=%b",i,lut[i]);
//    end
//end
//`endif

//initial begin
//    y[0]='b1;
//    x[0] = 'b0;
//    x_2_inv = 'b1;
//end



//always @(posedge clk)
initial
begin
    //z[0] <= ~rst ? angle: 'b0;
    //x[0] <= ~rst ? 'b1: 'b0;
    //y[0] <= ~rst ? 'b0: 'b0;
    x[0] <= 8'b01_000000;
    y[0] <= 'b0;
end

genvar i;

generate

    for(i=0; i< ITER_COUNT-1; i++)
    begin
        always @(posedge clk)
        begin
            if(~rst)
            begin
                //x[i+1] <= x[i] - sigma*2**-i*y[i]  +ve angle
                //x[i+1] <= x[i] + sigma*2**-i*y[i]  -ve angle
                //

                //flag_count = (flag=='b1) ? 'b1: (flag_count==3'd6 ? 3'd0: flag_count++);

                if(flag==1'b1)
                begin
                    flag_count <= 'b1;
                end
                else
                begin
                    if(flag_count=='d6)
                        flag_count <= 'd0;
                    else if(flag_count!='d0)
                        flag_count<= flag_count+1;
                end


                z[0] <= angle;
    
                x[i+1] <= (flag_count!='d0 ) ? (z[i][DATA_WIDTH-1] ? (x[i]+ (y[i]>>>i)): (x[i]- (y[i] >>>i ))): x[i+1];// shift right for every iteration to divide by 2
                //AM x[i+1] <= z[i][7] ? (x[i]+ ((2**(~i+1))*y[i])): (x[i]- ((2**(~i+1))*y[i]));// shift right for every iteration to divide by 2
                //y[i+1] = y[i] + (sigma*2**-i*x[i]); //+ve angle
                //y[i+1] = y[i] - (sigma*2**-i*x[i]); //+ve angle
                y[i+1] <= (flag_count!='d0 ) ? (z[i][DATA_WIDTH-1] ? (y[i] - (x[i]>>>i)): (y[i] + (x[i]>>>i))): y[i+1];
                //AM y[i+1] <= z[i][7] ? (y[i] - ((2**(~i+1))*y[i])): (y[i] + ((2**(~i+1))*y[i]));

                //subtracting tan-1(2**-i) values based on if angle is positive or negative
                //AM z[i+1] <= (flag_count!='d0 ) ? (z[i][DATA_WIDTH-1] ? z[i] + lut[7*i+:8] : z[i] - lut[7*i+:8]): z[i+1];
                z[i+1] <= (flag_count!='d0 ) ? (z[i][DATA_WIDTH-1] ? z[i] + lut[i] : z[i] - lut[i]): z[i+1];


                //`ifndef synth
                //    $display("x[%d]=%p, y[%d]=%p, z[%d]=%p",i,x,i,y,i,z);
                //`endif

                //TODO implement 1% error check
                //TODO assign cos_val and sin_val outside this for loop
                
                //`ifndef synth
                //    $display("cos_val=%b, sin_val=%b",cos_val,sin_val);
                //`endif
            end
            //else
            //begin
            //    for(int j=1;j<5; j++)
            //    begin
            //        x[j] <= 'b0;
            //        y[j] <= 'b0;
            //        z[j] <= 'b0;
            //    end
            //end
        end
    end
endgenerate

//preventing 1 clock cycle by assigning as wire
assign cos_val = x[MEM_SIZE-1]; // assigning final value of x as cos(theta)
assign sin_val = y[MEM_SIZE-1]; // assigning final value of y as sin(theta)


endmodule

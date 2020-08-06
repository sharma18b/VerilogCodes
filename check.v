module ALU8bit(number1,num_2,flagC,flagZ,flago,a);    
 
input [7:0]  number1,num_2;
wire [9:0] carry;
  
output [7:0] a;
wire [8:0] Result;
output flagC,flagZ;
output flago;   
assign carry[0] =0;


assign Result = number1 + num_2;

assign a[0] = Result[0];
assign a[1] = Result[1];
assign a[2] = Result[2];
assign a[3] = Result[3];
assign a[4] = Result[4];
assign a[5] = Result[5];
assign a[6] = Result[6];
assign a[7] = Result[7];
assign carry[1] = (carry[0] & (number1[0] ^ num_2[0])) | (number1[0] & num_2[0]) ;
assign carry[2] = (carry[1] & (number1[1] ^ num_2[1])) | (number1[1] & num_2[1]) ;
assign carry[3] = (carry[2] & (number1[2] ^ num_2[2])) | (number1[2] & num_2[2]) ;
assign carry[4] = (carry[3] & (number1[3] ^ num_2[3])) | (number1[3] & num_2[3]) ;
assign carry[5] = (carry[4] & (number1[4] ^ num_2[4])) | (number1[4] & num_2[4]) ;
assign carry[6] = (carry[5] & (number1[5] ^ num_2[5])) | (number1[5] & num_2[5]) ;
assign carry[7] = (carry[6] & (number1[6] ^ num_2[6])) | (number1[6] & num_2[6]) ;
assign carry[8] = (carry[7] & (number1[7] ^ num_2[7])) | (number1[7] & num_2[7]) ;


assign flago = carry[7] ^ carry[8];

assign flagC  = Result[8];
assign flagZ  = (Result == 9'b0);


endmodule



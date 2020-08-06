module ALU8bit(operand_1,operand_2,sum,Flag_Carry,Flag_Zero,Flag_Overflow,Flag_Negative);    
 

input [7:0]  operand_1,operand_2;  // Declaring two 8 bit inputs with msb as the sign bit.
  
output [7:0] sum;  //sum is the 8 bit output with msb as the sign bit
output Flag_Carry,Flag_Zero;   //Declaring Flag_Carry,Flag_Zero
output Flag_Overflow,Flag_Negative; // Declaring Flag_Overflow,Flag_Negative

wire [8:0] addn;  // Declaring an 9 bit number that will include the result and the 9th bit as carry
wire [8:0] carry; // Declaring an 9 bit carry number whose each bits are carry at each stage which includes final carry output as the msb 
assign carry[0] =0; // setting the initial cin value to be 0


assign addn = operand_1 + operand_2; //adding the two numbers



assign sum[0] = addn[0];
assign sum[1] = addn[1];
assign sum[2] = addn[2];
assign sum[3] = addn[3];
assign sum[4] = addn[4];
assign sum[5] = addn[5];
assign sum[6] = addn[6];
assign sum[7] = addn[7];
//assigning the first 8 bits of addn array to the final output array as the msb of the former is the final carry that need not be included in the latter



assign carry[1] = (carry[0] & (operand_1[0] ^ operand_2[0])) | (operand_1[0] & operand_2[0]) ;
assign carry[2] = (carry[1] & (operand_1[1] ^ operand_2[1])) | (operand_1[1] & operand_2[1]) ;
assign carry[3] = (carry[2] & (operand_1[2] ^ operand_2[2])) | (operand_1[2] & operand_2[2]) ;
assign carry[4] = (carry[3] & (operand_1[3] ^ operand_2[3])) | (operand_1[3] & operand_2[3]) ;
assign carry[5] = (carry[4] & (operand_1[4] ^ operand_2[4])) | (operand_1[4] & operand_2[4]) ;
assign carry[6] = (carry[5] & (operand_1[5] ^ operand_2[5])) | (operand_1[5] & operand_2[5]) ;
assign carry[7] = (carry[6] & (operand_1[6] ^ operand_2[6])) | (operand_1[6] & operand_2[6]) ;
assign carry[8] = (carry[7] & (operand_1[7] ^ operand_2[7])) | (operand_1[7] & operand_2[7]) ;

//calculating carry at each stage of bitwise addition


assign Flag_Overflow = carry[7] ^ carry[8];

//overflow occurs when the sum of two numbers lies out of the range [-128,127). this case occurs when either the final carry is 0 and the previous carry is 1 or vice versa

assign Flag_Carry  = addn[8];

//carry is the 9th element of addn array
assign Flag_Zero  = (addn == 9'b0);

//it is triggered when final result is zero


assign Flag_Negative = (~(carry[7] ^ carry[8])& sum[7]) + ((carry[7] ^ carry[8]) & addn[8]);

//by observation , no. is negative when 1.) no overflow -> sign bit is high , 2.)overflow -> check when carry is high

endmodule



/*
-> if the number is unsigned we dont need seperate carry and overflow flags as they are both the same


a.)100+49
100=01100100 , 49= 00110001
sum = 10010101, overflow=1,c=0,zero_flag=0,negative flag =0

b.)-2-1
-2=11111110, -1= 11111111
sum= 11111101  , c=1,overflow=0,zero_flag=0,negative flag =1


c.)51+28
51=00110011 , 28=00011100
sum= 01001111, carry=0, overflow=0, zero_flag=0,negative flag =0

d.)126-64
126= 01111110 , -64= 11000000
sum=00111110 carry=1, overflow=0,zero_flag=0,negative flag =0
*/

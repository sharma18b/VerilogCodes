
module mux4to1ifelse( select, d, q ); // initialising module

input[1:0] select; //declaring select inputs
input[3:0] d; // declaring inputs
output q; // declaring output
 // declaring wires
wire q;
wire[1:0] select;
wire[3:0] d;
//assigning output using continuous if elses
assign q = ( select == 2'b00 )? d[0] :  ( select == 2'b01 )? d[1] : ( select == 2'b10 )? d[2] : d[3];
endmodule   // ending module 
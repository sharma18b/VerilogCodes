
module mux3( select, d, q );

input[1:0] select; //input selects 
input[3:0] d; // declaring inputs
output q;   // declaring output q  

reg q; // forming reg
wire[1:0] select; // wire declaration
wire[3:0] d;
 
always @( select or d )
begin
   if( select == 2'b00) 
      q = d[0]; 

   if( select == 2'b01) 
      q = d[1];

   if( select == 2'b10) 
      q = d[2];

   if( select == 2'b11) 
      q = d[3];
end 

endmodule
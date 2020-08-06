
module mux4to1_using_always_and_case( select, d, q );


input[1:0] select; //declaring inputs for select 
input[3:0] d; // declaring inputs for mux
output  q; // declaring output     

reg       q;
wire[1:0] select;
wire[3:0] d; // declaring wires to be used

always @( select or d ) //sensitivities (mentioned) 
begin // initialising always 
   case( select ) //use of case to implement the value of output
        0 : q = d[0]; 
        1 : q = d[1];
        2 : q = d[2];
        3 : q = d[3];
   endcase
end // ending always

endmodule
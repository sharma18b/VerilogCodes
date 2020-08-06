
module mux2_1(a,b,sel,o); // 2*1 mux building
input a,b,sel; // defining inputs and output of 2*1 multiplexer
output o; //declaring the output
wire w1,seln,w2;  //wires


not (seln,sel);     // taking not of select input
and (w1,seln,a),(w2,sel,b); // implementing and gates acc to the standard relations of 2*1 mux 
or (o,w1,w2); // or gate of w1 and w2 gives the output
endmodule


module mux4_1(in,select,out); //4 * 1 multiplexer building 
input [3:0] in; // declaring inputs
input [1:0] select; // select inputs
output out; // output 
wire mux[2:0]; // wires initialisation

mux2_1   // using mux2_1 module 
m1 (.a(in[3]),.b(in[2]),.sel(select[0]),.o(mux[1])), //setting input and output of m1 i.e. first mux
m2 (.a(in[1]),.b(in[0]),.sel(select[0]),.o(mux[2])),//setting input and output of m2 i.e. sec mux
m3 (.a(mux[1]),.b(mux[2]),.sel(select[1]),.o(out));//setting input and output of m1 i.e. third mux
endmodule

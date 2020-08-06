

module parity_gen(a,b,c,parity); // parity generator

input a,b,c; // declaring the inputs
output parity; // declaring output i.e the parity

 assign parity = a^b^c; // parity is given by (a xor b xor c)

endmodule 
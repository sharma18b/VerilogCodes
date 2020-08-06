module cond_mux4_1(inp_a,inp_b,inp_c,inp_d,sel1,sel0,q); // initialising the module

input inp_a,inp_b,inp_c,inp_d,sel1,sel0; // declaring inputs 
output q; //declaring outputs

assign q = (sel1)?(sel0 ? inp_d:inp_c):(sel0 ? inp_b:inp_a); // assigning the value to the output directly
endmodule // ending the module

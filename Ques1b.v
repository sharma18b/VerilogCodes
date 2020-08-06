
module cond_mux4_1(inp_a,inp_b,inp_c,inp_d,sel1,sel0,q);

input inp_a,inp_b,inp_c,inp_d,sel1,sel0;
output q;

assign q = (sel1)?(sel0 ? inp_d:inp_c):(sel0 ? inp_b:inp_a);
endmodule
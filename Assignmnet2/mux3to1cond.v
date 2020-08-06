
module mux3to1cond(input wire a,input wire b,input wire c,input wire[1:0] sel,output wire y);

//initialising module and declaring inputs

assign y = (a&(sel==2'b00))|(b&(sel==2'b01))|(c&(sel==2'b10))|(1'bx&(sel==2'b11));

// assigning the values to output y

endmodule


module mux3to1alwcase(input wire a,input wire b,input wire c,input wire[1:0] sel,output reg o);   // initialised the module and declared the inputs and outputs 

always @(*) // initialised always  
begin 
case (sel)   // using case in always to give output its value
2'b00 : o = a;
2'b01 : o = b;
2'b10 : o = c;
2'b11 : o = 1'bx;
endcase
end 
endmodule   //ending module
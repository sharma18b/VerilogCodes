module compliment(a, b);
input [3:0]a;
output [3:0]b;
reg [3:0]c;
always@(*)
begin
c <= 4'b1001 - a;
end
assign b = c; 
endmodule 

module tbq4();
reg[3:0] a_t = 4'b0000;
wire[3:0] b_t = 4'b1001;
compliment av(.a(a_t),.b(b_t));
//$display("time =%g\t ,a_t=%b,b_t=%h", $time,a_t,b_t);
initial 
begin
//a_t = 4'b0000;
#5 a_t = 4'b0001;
#5 a_t = 4'b0010;
#5 a_t = 4'b0011;
#5 a_t = 4'b0100;
#5 a_t = 4'b0101;
#5 a_t = 4'b0110;
#5 a_t = 4'b0111;
#5 a_t = 4'b1000;
#5 a_t = 4'b1001;
//#5 a_t = 4'b0010;
end 
endmodule 
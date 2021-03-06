module mealy111(clk,rst,x_inp,y_out);
input clk,rst,x_inp;
output y_out;
reg y_out;
reg [2:0]state;
parameter S0 =0,S1 = 1,S2 = 2,S3 = 3;

always@(posedge clk or posedge rst)
begin
if (rst)
	begin 
	state = S0;
	y_out = 0;
	end
else 
case (state)
S0:if (x_inp)
	begin
	state  = S1;
	y_out = 0;
	end
else 
	begin
	state = S0;
	y_out = 0; 
	end
  
S1:if (x_inp)
	begin
	state = S2;
	y_out = 0;
	end
else 
	begin
	state = S0;
	y_out = 0; 
	end
S2:if (x_inp)
	begin
	state  <= S3;
	y_out <= 1;
	end
else 
	begin
	state = S0;
	y_out = 0; 
	end
S3:if (x_inp)
	begin
	state = S1;
	y_out = 0;
	end
else 
	begin
	state = S0;
	y_out = 0; 
	end 
endcase
end
endmodule 

module tbq1;
reg clk_t=0,rst_t=1,x_inp_t=0;
wire y_out_t;
mealy111 tb(clk_t,rst_t,x_inp_t,y_out_t);
always #5 clk_t=~clk_t;
initial 
begin
$display("time = %g\t,x_inp =%b,y_out=%b,clk_t=%b,rst_t=%b",$time,x_inp_t,y_out_t,rst_t,clk_t);
clk_t = 0;
#5 rst_t = 0;
#10 x_inp_t =0;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =0;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =0;
#10 x_inp_t =0;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#220 $stop;
end
endmodule  

module tlc
(
input reset,
input clock,
input Ta,
input Tb,
output reg[1:0]La,
output reg[1:0]Lb
);

	parameter green=0, yellow=1, red=2;

	always @(posedge clock or posedge reset)
	begin
		if(reset)
		begin
		La = red;
		Lb = green;
		end
		else
		begin
		if(Ta==0&&Tb==0)
		begin
			if(La==green&&Lb==red)
			begin
				La = yellow;
			end
			else if(La==yellow)
			begin
				La=red;
				Lb=green;
			end
			else if(Lb==green&&La==red)
			begin
				Lb = yellow;
			end
			else if(Lb==yellow)
			begin
				Lb=red;
				La=green;
			end
		end
		else if(Ta==0&&Tb==1)
		begin
			if(La==green&&Lb==red)
			begin
				La = yellow;
			end
			else if(La==yellow)
			begin
				La=red;
				Lb=green;
			end
			else
			begin
				La=red;
				Lb=green;
			end
		end
		else if(Ta==1&&Tb==0)
		begin
			if(Lb==green&&La==red)
			begin
				Lb = yellow;
			end
			else if(Lb==yellow)
			begin
				Lb=red;
				La=green;
			end
			else
			begin
				Lb=red;
				La=green;
			end
		end
		else
		begin
			if(La==green&&Lb==red)
			begin
				La = yellow;
			end
			else if(La==yellow)
			begin
				La=red;
				Lb=green;
			end
			else if(Lb==green&&La==red)
			begin
				Lb = yellow;
			end
			else if(Lb==yellow)
			begin
				Lb=red;
				La=green;
			end
		end
		end
		
	end
endmodule

module test();
  reg reset, clk, Ta, Tb;
  wire  [1:0] La, Lb;
  tlc DUT(reset, clk, Ta, Tb, La, Lb);
  initial
    begin
      clk = 1'b0;
      forever #5 clk = ~clk;
    end
    initial 
      begin
     //   $dumpfile("dump.vcd");
     //   $dumpvars(1,test);
        reset = 1'b1;
        #15 reset = 1'b0; Ta = 1'b0; Tb = 1'b0;
        #15 Ta = 1'b0; Tb = 1'b0;
        #15 Ta = 1'b1; Tb = 1'b0;
        #15 Ta = 1'b0; Tb = 1'b1;
        #15 Ta = 1'b1; Tb = 1'b1;
        #20;
        $finish;
      end
endmodule


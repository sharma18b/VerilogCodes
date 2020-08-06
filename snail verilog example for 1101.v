module snailMoore (input clk,
				input reset,
				input a,
				output y);
				
		reg[2:0] state, nextState;
		
		parameter S0 = 3'b000;
		parameter S1 = 3'b001;
		parameter S2 = 3'b010;
		parameter S3 = 3'b011;
		parameter S4 = 3'b100;
		
		// state register
		always @ (posedge clk, posedge reset)
			if (reset) state <= S0;
			else state <= nextState;
			
		// next state logic
		always @ (*) 
			case(state) 
				S0: if (a) nextState = S1;
					else nextState = S0;
				S1: if (a) nextState = S2;
					else nextState = S0;
				S2: if (a) nextState = S2;
					else nextState = S3;
				S3: if (a) nextState = S4;
					else nextState = S0;
				S4: if (a) nextState = S2;
					else nextState = S0;
				default: nextState = S0;
			endcase
			
		// output logic
		assign y = (state == S4);
endmodule
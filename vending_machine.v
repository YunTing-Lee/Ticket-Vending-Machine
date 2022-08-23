module vending_machine( costOfTicket, moneyToPay, totalMoney, clk, reset, howManyTicket, origin, destination, money );

input clk, reset ;
input [2:0] howManyTicket, origin, destination;
input [5:0] money ;
output reg [6:0] costOfTicket, moneyToPay, totalMoney; //票價、需付的錢、已付的錢
//設置內部狀態暫存器
reg [2:0] state;
reg [2:0] next_state;
 
parameter s0 = 3'd0; 
parameter s1 = 3'd1;  
parameter s2 = 3'd2;  
parameter s3 = 3'd3;

initial begin
	costOfTicket = 0 ;
	moneyToPay = 0 ;
	totalMoney = 0 ;
	state = s0 ;
	next_state = s0;
end


always @( posedge clk ) 
	begin
	if ( reset ) 
		begin
		costOfTicket = 0;
		moneyToPay = 0;
		//totalMoney = 0;
		state = s3;  // clr輸入"True"時為s0狀態(使用無阻礙指令避免衝突)
		end
	else 
		begin	
		state = next_state; // 改變下一個狀態
		//$display( "change state ",  state);
		end
	end

//將s0~s4狀態描寫      (做每一個state所需做的動作)
always @(state or posedge clk)     
	begin
	case( state ) 
		s0: begin   //選站
			totalMoney = 7'd0 ;
			moneyToPay = 7'd0 ;
			costOfTicket = 7'd0 ;
		end
		s1: begin  //張數
				if( origin == destination )
					costOfTicket =  5 ;
				else if ( origin > destination )
					costOfTicket = 5 +  (origin-destination) * 5  ;
				else
					costOfTicket =  5 + (destination-origin) * 5 ;	
				$display( "costOfTicket : ",  costOfTicket);
			if ( howManyTicket > 0 && howManyTicket < 6 ) begin
				costOfTicket = howManyTicket *  costOfTicket ;
				$display( "total Need Money : ",  costOfTicket);
			end
		end
		s2 : begin
			$display( "money",  money );
			totalMoney = totalMoney + money;     // 繳了多少錢
			if ( totalMoney <= costOfTicket ) 
				moneyToPay = costOfTicket - totalMoney ;   // 還差多少錢
			else 
				moneyToPay = 0 ;
			$display( "total ",  totalMoney , " dollars,  left ", moneyToPay , " dollars" );
		end
		s3: begin  // 吐票&找零
			if ( reset )
				$display( "cancel !! ticket : 0", "  return: ", totalMoney, " dollars" );
			else if ( totalMoney >= moneyToPay )
				$display(" tickets : ", howManyTicket,  "  return change: ", totalMoney - costOfTicket, " dollars" );
		end
	endcase
	
	end
	
//標示出state machine  (做state的切換 s0->s1->s3->s0)
always @(state or posedge clk)  //or totalMoney or howManyTicket or costOfTicket  
	begin
	case (state)
	s0: begin
		if ( origin > 0 && origin < 6 && destination > 0 && destination < 6 )
			next_state = s1 ;
		else 
			next_state = s0 ;
		//$display( "now state : s0, next state ",  next_state);
		end
	s1: begin
		if (reset )
			next_state = s3 ;
		if ( howManyTicket > 0 && howManyTicket < 6	)
			next_state = s2;   //s2
		else 
			next_state = s1;
		//$display( "now state : s1, next state ",  next_state);
		end
	s2: begin
		if ( reset )
			next_state = s3;
		else if ( costOfTicket > totalMoney )
			next_state = s2;
		else 
			next_state = s3;
		//$display( "now state : s2, next state ",  next_state);
		end
	s3: begin
		//if ( totalMoney >= costOfTicket ) 
		next_state = s0 ;
		//$display( "now state : s3, next state ",  next_state);
		end
		
	default: next_state = s0;
	endcase
	end
	
endmodule



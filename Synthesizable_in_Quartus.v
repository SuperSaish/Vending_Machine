// Earlier code was not synthesizable in Intel quartus Prime
//This code is synthesizable in Intel Quartus Prime
module Vending_machine(clk,rst,coin,cancel,restart,select,dispense,change,balance);
    input wire clk;          
    input wire rst;       
    input wire [1:0] coin;   // 10 - 10rs Coin ;  01 - 5rs Coin
    input wire cancel;   // Cancel button input
    input wire restart;  // Restart button input
    input wire [2:0] select; // 00-A(5rs) ; 01-B(10rs); 10-C(15rs); 11-D(20rs)
    output reg dispense;    // Dispense signal (product dispensed)
    output reg [3:0] change; // Change (2 bits for 4 products)
	  output reg [4:0] balance;
    reg [3:0] prices;
    parameter PRICE_A = 3'b001;
    parameter PRICE_B = 3'b010;
    parameter PRICE_C = 3'b011;
    parameter PRICE_D = 3'b100;

    always @(posedge clk) begin
        case(select)
            3'b001: prices = PRICE_A;
            3'b010: prices = PRICE_B;
            3'b011: prices = PRICE_C;
            3'b100: prices = PRICE_D;
            default: prices = 4'b0000;
        endcase
    end
	 
    
    reg [3:0] product_selected;

    always @(posedge clk or posedge rst) begin
      if (rst) begin
            balance <= 3'b000;
        end else if (coin == 2'b10) begin // 10rs
            balance <= balance + 3'b010;
        end else if (coin == 2'b01) begin //  5rs
            balance <= balance + 3'b001;
        end else if (coin == 2'b00) begin //  5rs
            balance <= 3'b000;
        end
   

        if (rst) begin
            product_selected <= 4'b0000;
        end else if (select != 4'b0000) begin
            product_selected <= select;
        end
  

        if (rst) begin
            dispense <= 0;
            change <= 4'b0000;
        end 
		  else if (cancel) begin
            dispense <= 0;
            change <= balance;
            balance <= 1'b0;
            product_selected <= 4'b0000;
        end 
       else if (restart) begin
            dispense <= 0;
            change <= 3'b00;
            balance <= 1'b0;
            product_selected <= 4'b0000;
        end 
		  else if (balance >= prices && product_selected != 4'b0000) begin
            dispense <= 1;
            change <= balance - prices;
            balance <= 'b0;
            product_selected <= 4'b0000;
        
        end
    end
	 

endmodule

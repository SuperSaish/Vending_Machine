module testbench_vending_machine();

    // Define parameters for product prices
    parameter PRICE_A = 5;
    parameter PRICE_B = 10;
    parameter PRICE_C = 15;
    parameter PRICE_D = 20;

    // Declare signals
    reg clk;
    reg rst;
    reg [1:0] coin;
    reg cancel;
    reg restart;
    reg [1:0] select;
  wire [4:0]balance;
    wire dispense;
    wire [3:0] change;

    // Instantiate the vending machine module
    vending uut (
        .clk(clk),
        .rst(rst),
        .coin(coin),
        .cancel(cancel),
        .restart(restart),
        .select(select),
        .dispense(dispense),
      .change(change),
      .balance(balance)
    );

    // Clock generation
    always begin
        clk = ~clk;
        #5; // Toggle the clock every 5 time units
    end

    // Initialize signals
    initial begin
      $dumpfile("dump.vcd"); $dumpvars(1);
      // Continuous monitoring of signals
        $monitor(" clk=%b, rst=%b, coin=%b, cancel_btn=%b, restart_btn=%b, select=%b, dispense=%b, change=%b balance=%b", clk, rst, coin, cancel, restart, select, dispense, change,balance);
        clk = 0;
        rst = 1;
        coin = 2'b00; // 5rs coin
        cancel = 0;
        restart = 0;
        select = 4'b0000;
        #10;
        rst = 0;
        coin = 2'b01;
        select = 2'b01;
      #10
      coin = 2'b01;
        select = 2'b01;

        
        
        
        // Finish simulation after some time
        #10;
      coin = 2'b00;
      #10
      coin = 2'b10;
      select = 2'b11;
      #10
      restart=1'b1;
      #10
      restart=1'b0;
      coin = 2'b10;
      select = 2'b11;
      cancel = 1'b1;
      #10
      cancel = 1'b0;
      coin = 2'b10;
      select = 2'b11;
      #10
      coin = 2'b10;
      select = 2'b11;
      #10
      coin = 2'b00;
      select = 2'b00;
      #10
      coin = 2'b10;
      #10
      coin = 2'b01;
      cancel = 1'b1;
      coin = 2'b00;
      #10
      cancel = 1'b0;
     
      #10
      coin = 2'b01;
      select = 2'b01;
      #10
      coin = 2'b0;
      
      
      
        $finish;
    end

endmodule

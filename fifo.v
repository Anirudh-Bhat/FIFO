`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2018 03:21:36 PM
// Design Name: 
// Module Name: fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo(
    input clk,rst,read,write,
    input [3:0] data_in,
    output reg full,empty,
    output reg [3:0] data_out
    );
    reg [3:0] mem [0:3];
    reg[2:0] count;
    reg [1:0] rp,wp,a,c;
    reg b,rc,wc;
    always@(posedge clk)
    begin
    if(rst)
    begin
    rc<=0;
    wc<=0;
    data_out<=4'd0;
    full<=0;
    c<=2'd0;
    empty<=0;
    wp<=0;
    rp<=0;
    mem[0]<=4'd0;
    mem[1]<=4'd0;
    mem[2]<=4'd0;
    mem[3]<=4'd0;
    a<=2'd0;
    b<=1'd0;
    count<=3'd0;
    end
    else
    begin
    case(count)
    3'd0:empty<=1'd1;
    3'd4:full<=1'd1;
    default:{empty,full}<=2'd0;
    endcase
    b<=b+1;
    c[b]<=write;
    a[b]<=read;
    case({a,c,read,write})
    6'b101011:{rc,wc}<=2'b11;
    6'b101001:{rc,wc}<=2'b01;
    6'b101010:{rc,wc}<=2'b10;
    6'b010111:{rc,wc}<=2'b11;
    6'b010101:{rc,wc}<=2'b01;
    6'b010110:{rc,wc}<=2'b10;
    6'b100010:{rc,wc}<=2'b10;
    6'b010010:{rc,wc}<=2'b10;
    6'b001001:{rc,wc}<=2'b01;
    6'b000101:{rc,wc}<=2'b01;
    default:{rc,wc}<=2'b00;
    endcase
    if(rc&(!empty))
    begin
    data_out<=mem[rp];
    rp<=rp+1;
    count<=count-1;
    end
    if(wc&(!full))
    begin
    mem[wp]<=data_in;
    wp<=wp+1;
    count<=count+1;
    end
    end
    end
    endmodule
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     
    
    
    

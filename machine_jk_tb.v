`timescale 1ns / 1ps
module machine_jk_tb;        
    reg x;
    reg rst;
    reg clk;    
    wire F;       
    machine_jk uut(.x(x), .rst(rst), .clk(clk), .F(F));
    reg[19:0] input_data_2;
    integer shift_amount_2;
    initial begin
        input_data_2=20'b11110000000111000100;        
        shift_amount_2=0;
        x=0; rst=1; #22;
        rst=1; #5;
        rst=0; #98;
        rst=1; #2;
        rst=0; #93;
        $finish;        
    end
    initial begin
        clk=1;
        forever begin
            #5;
            clk=~clk;
        end
    end
    always @(posedge clk or posedge rst) begin
        #2;x=input_data_2>>shift_amount_2;
        shift_amount_2=shift_amount_2+1;
    end      
endmodule
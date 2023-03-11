`timescale 1ns / 1ps
module jkff (input j,  
              input k,  
              input rst,  
              input clk,  
              output reg q);  
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            q <= 1'b0;
            end 
        else begin
            case({j,k})
                2'b00: begin
                    q <= q;
                end
                2'b01: begin
                    q <= 0;
                end
                2'b10: begin
                    q <= 1;
                end
                2'b11: begin
                    q <= ~q;
                end 
            endcase
        end
    end 			  
endmodule 
`timescale 1ns / 1ps
module machine_jk(
    input x,
    input rst,  
    input clk,
    output F
    );
    //current_state[2] = A
    //current_state[1] = B
    //current_state[0] = C
    reg [2:0] current_state_jk = 3'b000;
    //next_state[2] = d_A
    //next_state[1] = d_B
    //next_state[0] = d_C
    wire [2:0] next_state_jk;
    jkff jk_A (
                .j(current_state_jk[1]&x),
                .k(~current_state_jk[2] | current_state_jk[1]),
                .clk(clk),
                .rst(rst),
                .q(next_state_jk[2]));
    jkff jk_B (
                .j(~current_state_jk[2]&x),
                .k(current_state_jk[1]&x),
                .clk(clk),
                .rst(rst),
                .q(next_state_jk[1]));
    jkff jk_C (
                .j(~current_state_jk[0]&~x),
                .k(current_state_jk[0]&~x),
                .clk(clk),
                .rst(rst),
                .q(next_state_jk[0]));    
    always @(rst or next_state_jk) begin
        if(rst) begin current_state_jk <= 3'b000; end
        else begin current_state_jk <= next_state_jk; end
    end      
    assign F = (current_state_jk[2]&current_state_jk[0]);
endmodule
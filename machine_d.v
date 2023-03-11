`timescale 1ns / 1ps
module machine_d(
    input x,
    input rst,  
    input clk,
    output F
    );
    //current_state[2] = A
    //current_state[1] = B
    //current_state[0] = C
    reg [2:0] current_state = 3'b000;
    //next_state[2] = d_A
    //next_state[1] = d_B
    //next_state[0] = d_C
    wire [2:0] next_state;
    dff d_A (
                .d((current_state[2]) | (current_state[1]&x)),
                .clk(clk),
                .rst(rst),
                .q(next_state[2]));
    dff d_B (
                .d((current_state[1]&(~x)) | (~current_state[2]&~current_state[1]&x)),
                .clk(clk),
                .rst(rst),
                .q(next_state[1]));
    dff d_C (
                .d((~current_state[0]&(~x)) | (current_state[0]&x)),
                .clk(clk),
                .rst(rst),
                .q(next_state[0]));    
    always @(rst or next_state) begin
        if(rst) begin current_state <= 3'b000; end
        else begin current_state <= next_state; end
    end   
    assign F = (current_state[2]&current_state[0]);
endmodule
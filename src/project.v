`default_nettype none

// Ring Oscillator
module ring_oscillator (
    input wire clk,
    input wire rst_n,
    output reg ro_out
);

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        ro_out <= 0;
    else
        ro_out <= ~ro_out;
end

endmodule

// Sampler
module sampler (
    input wire clk,
    input wire ro_out,
    output reg sampled_bit
);

always @(posedge clk) begin
    sampled_bit <= ro_out;
end

endmodule

// Health Checker
module health_checker (
    input wire clk,
    input wire sampled_bit,
    output reg alarm
);

reg [3:0] count;

always @(posedge clk) begin
    if(sampled_bit)
        count <= count + 1;
    else
        count <= 0;

    if(count > 8)
        alarm <= 1;
    else
        alarm <= 0;
end

endmodule

// Post Processing
module post_processing (
    input wire sampled_bit,
    output wire clean_bit
);

assign clean_bit = sampled_bit;

endmodule

// Top Module
module tt_um_karthik_trng (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

wire ro_out;
wire sampled_bit;
wire clean_bit;
wire alarm;

// Ring Oscillator
ring_oscillator ro_inst (
    .clk(clk),
    .rst_n(rst_n),
    .ro_out(ro_out)
);

// Sampler
sampler samp_inst (
    .clk(clk),
    .ro_out(ro_out),
    .sampled_bit(sampled_bit)
);

// Health Checker
health_checker hc_inst (
    .clk(clk),
    .sampled_bit(sampled_bit),
    .alarm(alarm)
);

// Post Processing
post_processing pp_inst (
    .sampled_bit(sampled_bit),
    .clean_bit(clean_bit)
);

// Output mapping
assign uo_out[0] = clean_bit;
assign uo_out[1] = alarm;
assign uo_out[7:2] = 6'b000000;

assign uio_out = 8'b00000000;
assign uio_oe  = 8'b00000000;

wire _unused = &{ui_in, uio_in, ena, 1'b0};

endmodule

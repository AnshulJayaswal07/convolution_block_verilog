`timescale 1ns / 1ps

module tb_conv_forward_pass;

    parameter IN_CHANNELS  = 2;
    parameter OUT_CHANNELS = 1;
    parameter IN_HEIGHT    = 4;
    parameter IN_WIDTH     = 4;
    parameter KERNEL_SIZE  = 2;
    parameter STRIDE       = 2;
    parameter PADDING      = 0;
    parameter OUT_HEIGHT   = ((IN_HEIGHT + 2*PADDING - KERNEL_SIZE)/STRIDE + 1);
    parameter OUT_WIDTH    = ((IN_WIDTH  + 2*PADDING - KERNEL_SIZE)/STRIDE + 1);
    parameter DATA_WIDTH   = 32;

    reg clk, rst;

    reg  [IN_CHANNELS*IN_HEIGHT*IN_WIDTH*DATA_WIDTH-1:0] input_tensor_flat;
    reg  [OUT_CHANNELS*IN_CHANNELS*KERNEL_SIZE*KERNEL_SIZE*DATA_WIDTH-1:0] weights_flat;
    reg  [OUT_CHANNELS*DATA_WIDTH-1:0] bias_flat;
    wire [OUT_CHANNELS*OUT_HEIGHT*OUT_WIDTH*DATA_WIDTH-1:0] output_tensor_flat;

    // DUT instantiation
    conv_forward_pass #(
        .IN_CHANNELS(IN_CHANNELS),
        .OUT_CHANNELS(OUT_CHANNELS),
        .IN_HEIGHT(IN_HEIGHT),
        .IN_WIDTH(IN_WIDTH),
        .OUT_HEIGHT(OUT_HEIGHT),
        .OUT_WIDTH(OUT_WIDTH),
        .KERNEL_SIZE(KERNEL_SIZE),
        .STRIDE(STRIDE),
        .PADDING(PADDING),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .input_tensor_flat(input_tensor_flat),
        .weights_flat(weights_flat),
        .bias_flat(bias_flat),
        .output_tensor_flat(output_tensor_flat)
    );

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    integer i;
    reg [DATA_WIDTH-1:0] temp_data [0:31];

    initial begin
        // Reset
        rst = 1;
        #20;
        rst = 0;

        // Fill input_tensor: Channel 0 = 1 to 16, Channel 1 = 101 to 116
        for (i = 0; i < 16; i = i + 1)
            temp_data[i] = i + 1;
        for (i = 0; i < 16; i = i + 1)
            temp_data[16 + i] = 101 + i;

        input_tensor_flat = 0;
        for (i = 0; i < 32; i = i + 1)
            input_tensor_flat = input_tensor_flat | (temp_data[i] << (i * DATA_WIDTH));

        // Weights: OUT_CH0 ? CH0: all 1s, CH1: all 2s
        for (i = 0; i < 4; i = i + 1) // 2x2 kernel for CH0
            temp_data[i] = 32'd1;
        for (i = 0; i < 4; i = i + 1) // 2x2 kernel for CH1
            temp_data[4 + i] = 32'd2;

        weights_flat = 0;
        for (i = 0; i < 8; i = i + 1)
            weights_flat = weights_flat | (temp_data[i] << (i * DATA_WIDTH));

        // Bias
        bias_flat = 32'd10;

        #100;

        $display("Output Tensor:");
        for (i = 0; i < OUT_HEIGHT * OUT_WIDTH; i = i + 1) begin
            $display("output_tensor_flat[%0d] = %0d", i, output_tensor_flat[i*DATA_WIDTH +: DATA_WIDTH]);
        end

        $finish;
    end

endmodule

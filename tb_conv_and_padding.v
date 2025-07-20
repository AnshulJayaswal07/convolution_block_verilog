`timescale 1ns / 1ps

module tb_conv_and_padding;

    // Inputs to conv_dimensions
    reg [15:0] IN_HEIGHT;
    reg [15:0] IN_WIDTH;
    reg [15:0] KERNEL_SIZE;
    reg [15:0] STRIDE;
    reg [15:0] PADDING;

    // Outputs from conv_dimensions
    wire [15:0] OUT_HEIGHT;
    wire [15:0] OUT_WIDTH;

    // Inputs to padding_check
    reg signed [15:0] coord;
    reg [15:0] max_coord;
    reg [7:0] memory_data;

    // Outputs from padding_check
    wire valid_coord;
    wire [7:0] input_data;

    // Instantiate conv_dimensions
    conv_dimensions uut_conv_dims (
        .IN_HEIGHT(IN_HEIGHT),
        .IN_WIDTH(IN_WIDTH),
        .KERNEL_SIZE(KERNEL_SIZE),
        .STRIDE(STRIDE),
        .PADDING(PADDING),
        .OUT_HEIGHT(OUT_HEIGHT),
        .OUT_WIDTH(OUT_WIDTH)
    );

    // Instantiate padding_check
    padding_check #(
        .COORD_WIDTH(16),
        .DATA_WIDTH(8)
    ) uut_padding_check (
        .coord(coord),
        .max_coord(max_coord),
        .memory_data(memory_data),
        .valid_coord(valid_coord),
        .input_data(input_data)
    );

    initial begin
        $display("=== Starting Combined Testbench for conv_dimensions + padding_check ===");

        // Step 1: Provide convolution parameters
        IN_HEIGHT   = 5;
        IN_WIDTH    = 5;
        KERNEL_SIZE = 3;
        STRIDE      = 1;
        PADDING     = 1;

        #10; // wait for outputs to settle
        $display("Computed Output Size: OUT_HEIGHT = %0d, OUT_WIDTH = %0d", OUT_HEIGHT, OUT_WIDTH);

        // Step 2: Now test padding_check using OUT_WIDTH/OUT_HEIGHT as max_coord
        memory_data = 8'hAB;
        max_coord = IN_WIDTH;

        // Check some coord values
        coord = -1;
        #5 $display("coord = %0d => valid = %b, data = 0x%0h", coord, valid_coord, input_data);

        coord = 0;
        #5 $display("coord = %0d => valid = %b, data = 0x%0h", coord, valid_coord, input_data);

        coord = 4;
        #5 $display("coord = %0d => valid = %b, data = 0x%0h", coord, valid_coord, input_data);

        coord = 5;
        #5 $display("coord = %0d => valid = %b, data = 0x%0h", coord, valid_coord, input_data);

        coord = 6;
        #5 $display("coord = %0d => valid = %b, data = 0x%0h", coord, valid_coord, input_data);

        $display("=== Test Completed ===");
        $finish;
    end

endmodule

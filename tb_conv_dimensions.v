module tb_conv_dimensions;
    reg [15:0] IN_HEIGHT;
    reg [15:0] IN_WIDTH;
    reg [15:0] KERNEL_SIZE;
    reg [15:0] STRIDE;
    reg [15:0] PADDING;
    wire [15:0] OUT_HEIGHT;
    wire [15:0] OUT_WIDTH;

    conv_dimensions uut (
        .IN_HEIGHT(IN_HEIGHT),
        .IN_WIDTH(IN_WIDTH),
        .KERNEL_SIZE(KERNEL_SIZE),
        .STRIDE(STRIDE),
        .PADDING(PADDING),
        .OUT_HEIGHT(OUT_HEIGHT),
        .OUT_WIDTH(OUT_WIDTH)
    );

    initial begin
        // Test Case 1
        IN_HEIGHT   = 16'd32;
        IN_WIDTH    = 16'd32;
        KERNEL_SIZE = 16'd3;
        STRIDE      = 16'd1;
        PADDING     = 16'd1;

        #10;
        $display("OUT_HEIGHT = %d, OUT_WIDTH = %d", OUT_HEIGHT, OUT_WIDTH);
        // Expected: 32 x 32

        // Test Case 2
        IN_HEIGHT   = 16'd28;
        IN_WIDTH    = 16'd28;
        KERNEL_SIZE = 16'd5;
        STRIDE      = 16'd1;
        PADDING     = 16'd0;

        #10;
        $display("OUT_HEIGHT = %d, OUT_WIDTH = %d", OUT_HEIGHT, OUT_WIDTH);
        // Expected: 24 x 24

        // End simulation
        #10;
        $finish;
    end
endmodule

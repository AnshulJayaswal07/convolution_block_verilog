module conv_dimensions(
    input  [15:0] IN_HEIGHT,
    input  [15:0] IN_WIDTH,
    input  [15:0] KERNEL_SIZE,
    input  [15:0] STRIDE,
    input  [15:0] PADDING,
    output reg [15:0] OUT_HEIGHT,
    output reg [15:0] OUT_WIDTH
);

    always @(*) begin
        if (STRIDE != 0) begin
            OUT_HEIGHT = (IN_HEIGHT + (2 * PADDING) - KERNEL_SIZE) / STRIDE + 1;
            OUT_WIDTH  = (IN_WIDTH  + (2 * PADDING) - KERNEL_SIZE) / STRIDE + 1;
        end else begin
            OUT_HEIGHT = 16'd0;  // Prevent divide-by-zero
            OUT_WIDTH  = 16'd0;
        end
    end

endmodule

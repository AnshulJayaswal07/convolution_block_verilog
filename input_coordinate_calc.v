module input_coordinate_calc #(
    parameter ADDR_WIDTH = 16,
    parameter STRIDE     = 1,
    parameter PADDING    = 1
)(
    input  [ADDR_WIDTH-1:0] output_coord,
    input  [ADDR_WIDTH-1:0] kernel_coord,
    output signed [ADDR_WIDTH:0] input_coord
);

    wire [ADDR_WIDTH-1:0] stride_mult;

    assign stride_mult = output_coord * STRIDE;
    assign input_coord = $signed(stride_mult + kernel_coord) - PADDING;

endmodule

module weight_loader #(
    parameter OUT_CHANNELS = 4,
    parameter IN_CHANNELS  = 3,
    parameter KERNEL_SIZE  = 3,
    parameter DATA_WIDTH   = 32
)(
    input clk,
    input sel_bias, // 1: output bias, 0: output weights
    output reg [(TOTAL_OUTPUT_WIDTH-1):0] data_out
);

    localparam TOTAL_WEIGHTS = OUT_CHANNELS * IN_CHANNELS * KERNEL_SIZE * KERNEL_SIZE;
    localparam TOTAL_BIASES  = OUT_CHANNELS;
    localparam MAX_COUNT     = (TOTAL_WEIGHTS > TOTAL_BIASES) ? TOTAL_WEIGHTS : TOTAL_BIASES;
    localparam TOTAL_OUTPUT_WIDTH = MAX_COUNT * DATA_WIDTH;

    reg [DATA_WIDTH-1:0] weights [0:TOTAL_WEIGHTS-1];
    reg [DATA_WIDTH-1:0] bias    [0:TOTAL_BIASES-1];
    reg [TOTAL_OUTPUT_WIDTH-1:0] flat_weights;
    reg [TOTAL_OUTPUT_WIDTH-1:0] flat_bias;

    integer i;
    initial begin
        $readmemh("weights.txt", weights);
        $readmemh("bias.txt", bias);
    end

    always @(*) begin
        flat_weights = {TOTAL_OUTPUT_WIDTH{1'b0}};
        for (i = 0; i < TOTAL_WEIGHTS; i = i + 1) begin
            flat_weights[(i*DATA_WIDTH) +: DATA_WIDTH] = weights[i];
        end

        flat_bias = {TOTAL_OUTPUT_WIDTH{1'b0}};
        for (i = 0; i < TOTAL_BIASES; i = i + 1) begin
            flat_bias[(i*DATA_WIDTH) +: DATA_WIDTH] = bias[i];
        end
    end

    always @(posedge clk) begin
        data_out <= sel_bias ? flat_bias : flat_weights;
    end

endmodule

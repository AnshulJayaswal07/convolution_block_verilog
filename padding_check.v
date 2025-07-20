module padding_check #(
    parameter COORD_WIDTH = 16,
    parameter DATA_WIDTH  = 8
)(
    input  signed [COORD_WIDTH-1:0] coord,
    input        [COORD_WIDTH-1:0] max_coord,
    input        [DATA_WIDTH-1:0]  memory_data,

    output       valid_coord,
    output [DATA_WIDTH-1:0] input_data
);

    assign valid_coord = (coord >= 0) && (coord < max_coord);
    assign input_data = valid_coord ? memory_data : {DATA_WIDTH{1'b0}};

endmodule

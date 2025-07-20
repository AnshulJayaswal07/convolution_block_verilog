module tb_padding_check;

    parameter COORD_WIDTH = 8;
    parameter DATA_WIDTH = 8;

    reg signed [COORD_WIDTH-1:0] coord;
    reg        [COORD_WIDTH-1:0] max_coord;
    reg        [DATA_WIDTH-1:0]  memory_data;

    wire valid_coord;
    wire [DATA_WIDTH-1:0] input_data;

    padding_check #(
        .COORD_WIDTH(COORD_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) uut (
        .coord(coord),
        .max_coord(max_coord),
        .memory_data(memory_data),
        .valid_coord(valid_coord),
        .input_data(input_data)
    );

    initial begin
        max_coord = 8'd5;      // Valid coordinates: 0 to 4
        memory_data = 8'hAA;   // Arbitrary data

        coord = -1;
        #10 $display("coord=%d, valid=%b, data=0x%02X", coord, valid_coord, input_data); // 0

        coord = 0;
        #10 $display("coord=%d, valid=%b, data=0x%02X", coord, valid_coord, input_data); // AA

        coord = 4;
        #10 $display("coord=%d, valid=%b, data=0x%02X", coord, valid_coord, input_data); // AA

        coord = 5;
        #10 $display("coord=%d, valid=%b, data=0x%02X", coord, valid_coord, input_data); // 0

        coord = 10;
        #10 $display("coord=%d, valid=%b, data=0x%02X", coord, valid_coord, input_data); // 0

        $finish;
    end
endmodule

module tb_input_coordinate_calc;

    parameter ADDR_WIDTH = 8;

    reg  [ADDR_WIDTH-1:0] output_coord;
    reg  [ADDR_WIDTH-1:0] kernel_coord;
    wire signed [ADDR_WIDTH:0] input_coord;

    // Instantiate with STRIDE=1, PADDING=1
    input_coordinate_calc #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .STRIDE(1),
        .PADDING(1)
    ) uut (
        .output_coord(output_coord),
        .kernel_coord(kernel_coord),
        .input_coord(input_coord)
    );

    initial begin
        // Case 1: Output 0, Kernel 0
        output_coord = 0;
        kernel_coord = 0;
        #10;
        $display("Input Coord = %d", input_coord); // Expected: -1

        // Case 2: Output 1, Kernel 0
        output_coord = 1;
        kernel_coord = 0;
        #10;
        $display("Input Coord = %d", input_coord); // Expected: 0

        // Case 3: Output 1, Kernel 1
        output_coord = 1;
        kernel_coord = 1;
        #10;
        $display("Input Coord = %d", input_coord); // Expected: 1

        // Case 4: Output 2, Kernel 2
        output_coord = 2;
        kernel_coord = 2;
        #10;
        $display("Input Coord = %d", input_coord); // Expected: 3

        $finish;
    end
endmodule

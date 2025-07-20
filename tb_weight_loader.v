module tb_weight_loader;
    reg clk;
    reg sel_bias;
    wire [(weight_loader.TOTAL_OUTPUT_WIDTH-1):0] data_out;

    weight_loader uut (
        .clk(clk),
        .sel_bias(sel_bias),
        .data_out(data_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        sel_bias = 0;
        #20;
        sel_bias = 1;
        #20;
        $finish;
    end
endmodule

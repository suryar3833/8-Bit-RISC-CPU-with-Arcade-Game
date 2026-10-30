module game_io (

    input wire clk, rst, io_write,
    input wire [7:0] io_wdata, io_addr,
    input wire [1:0] game_mode,
    input wire [3:0] controls,

    output reg [7:0] io_rdata, ball_x, ball_y, paddle1_x, paddle2_x, score1, score2, brick_state
);

    // ---------------------------------------------------------
    // Frame timer: 50 MHz / 1,000,000 = 50 frames per second.
    // tick_flag goes to 1 once per frame. The CPU reads it at 0xF9
    // and clears it by writing to 0xF9.
    // ---------------------------------------------------------
    reg [19:0] tick_count;
    reg        tick_flag;

    // ---------------------------------------------------------
    // CPU reads: address decoder (a multiplexer)
    // ---------------------------------------------------------
    always @(*) begin
        case (io_addr)
            8'hF0: io_rdata = {6'b0, game_mode};
            8'hF1: io_rdata = {4'b0, controls};
            8'hF2: io_rdata = ball_x;
            8'hF3: io_rdata = ball_y;
            8'hF4: io_rdata = paddle1_x;
            8'hF5: io_rdata = paddle2_x;
            8'hF6: io_rdata = score1;
            8'hF7: io_rdata = score2;
            8'hF8: io_rdata = brick_state;
            8'hF9: io_rdata = {7'b0, tick_flag};
            default: io_rdata = 8'h00;
        endcase
    end

    // ---------------------------------------------------------
    // CPU writes + frame timer, on the rising clock edge
    // ---------------------------------------------------------
    always @(posedge clk) begin
        if (rst) begin
            ball_x      <= 8'h00;
            ball_y      <= 8'h00;
            paddle1_x   <= 8'h00;
            paddle2_x   <= 8'h00;
            score1      <= 8'h00;
            score2      <= 8'h00;
            brick_state <= 8'h00;
            tick_count  <= 20'd0;
            tick_flag   <= 1'b0;
        end
        else begin

            // CPU write
            if (io_write) begin
                case (io_addr)
                    8'hF2: ball_x      <= io_wdata;
                    8'hF3: ball_y      <= io_wdata;
                    8'hF4: paddle1_x   <= io_wdata;
                    8'hF5: paddle2_x   <= io_wdata;
                    8'hF6: score1      <= io_wdata;
                    8'hF7: score2      <= io_wdata;
                    8'hF8: brick_state <= io_wdata;
                    8'hF9: tick_flag   <= 1'b0;     // any write clears the tick
                    default: ;                      // ignore other addresses
                endcase
            end

            // Frame timer (written last, so a new tick wins over a clear)
            if (tick_count == 20'd999999) begin
                tick_count <= 20'd0;
                tick_flag  <= 1'b1;
            end
            else begin
                tick_count <= tick_count + 1'b1;
            end

        end
    end

endmodule

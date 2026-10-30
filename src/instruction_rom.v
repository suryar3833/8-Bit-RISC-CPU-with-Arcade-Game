// ---------------------------------------------------------------
// Program size: 225 of 256 instructions
// ---------------------------------------------------------------
module instruction_rom(
	input [7:0] address,
	output reg [15:0] instruction
);

	always @(*)
	begin
		case (address)
			8'd0: instruction = 16'h1000;   // LDI r0, 0               ; r0 = 0 forever
			8'd1: instruction = 16'h1E01;   // LDI r7, 1               ; r7 = 1 forever
			8'd2: instruction = 16'h1278;   // LDI r1, 120
			8'd3: instruction = 16'hA1F2;   // ST  r1, BALL_X          ; ball in the middle
			8'd4: instruction = 16'h125A;   // LDI r1, 90
			8'd5: instruction = 16'hA1F3;   // ST  r1, BALL_Y
			8'd6: instruction = 16'h1250;   // LDI r1, 80
			8'd7: instruction = 16'hA1F4;   // ST  r1, PAD1            ; both paddles start at 80
			8'd8: instruction = 16'hA1F5;   // ST  r1, PAD2
			8'd9: instruction = 16'hA0F6;   // ST  r0, SCORE1          ; scores = 0
			8'd10: instruction = 16'hA0F7;   // ST  r0, SCORE2
			8'd11: instruction = 16'h12FF;   // LDI r1, 0xFF
			8'd12: instruction = 16'hA1F8;   // ST  r1, BRICKS          ; all 8 bricks alive
			8'd13: instruction = 16'hA700;   // ST  r7, DIR_X           ; ball moves right ...
			8'd14: instruction = 16'hA701;   // ST  r7, DIR_Y           ; ... and down
			8'd15: instruction = 16'h92F9;   // LD  r1, TICK
			8'd16: instruction = 16'h5248;   // OR  r1, r1, r1          ; set the zero flag from r1
			8'd17: instruction = 16'h800F;   // BZ  main                ; no tick yet -> keep waiting
			8'd18: instruction = 16'hA0F9;   // ST  r0, TICK            ; acknowledge the tick
			8'd19: instruction = 16'h92F0;   // LD  r1, MODE
			8'd20: instruction = 16'h3678;   // SUB r3, r1, r7          ; mode - 1
			8'd21: instruction = 16'h801B;   // BZ  m_pong              ; mode == 1 -> Pong
			8'd22: instruction = 16'h1402;   // LDI r2, 2
			8'd23: instruction = 16'h3650;   // SUB r3, r1, r2          ; mode - 2
			8'd24: instruction = 16'hC000;   // BNZ start               ; not 1 and not 2 -> idle (home / invalid): re-init
			8'd25: instruction = 16'h1CE1;   // LDI r6, 225             ; Breakout: paddle X limit
			8'd26: instruction = 16'h701C;   // JMP m_common
			8'd27: instruction = 16'h1CA7;   // LDI r6, 167             ; Pong: paddle Y limit
			8'd28: instruction = 16'h92F1;   // LD  r1, CTRL
			8'd29: instruction = 16'h1401;   // LDI r2, 1
			8'd30: instruction = 16'h4650;   // AND r3, r1, r2          ; button 0 pressed?
			8'd31: instruction = 16'h8026;   // BZ  p1_dn
			8'd32: instruction = 16'h98F4;   // LD  r4, PAD1
			8'd33: instruction = 16'h5B20;   // OR  r5, r4, r4
			8'd34: instruction = 16'h802E;   // BZ  p1_end              ; already at 0
			8'd35: instruction = 16'h3938;   // SUB r4, r4, r7
			8'd36: instruction = 16'hA4F4;   // ST  r4, PAD1
			8'd37: instruction = 16'h702E;   // JMP p1_end
			8'd38: instruction = 16'h1402;   // LDI r2, 2
			8'd39: instruction = 16'h4650;   // AND r3, r1, r2          ; button 1 pressed?
			8'd40: instruction = 16'h802E;   // BZ  p1_end
			8'd41: instruction = 16'h98F4;   // LD  r4, PAD1
			8'd42: instruction = 16'h3B30;   // SUB r5, r4, r6
			8'd43: instruction = 16'h802E;   // BZ  p1_end              ; already at the limit
			8'd44: instruction = 16'h2938;   // ADD r4, r4, r7
			8'd45: instruction = 16'hA4F4;   // ST  r4, PAD1
			8'd46: instruction = 16'h92F3;   // LD  r1, BALL_Y
			8'd47: instruction = 16'h9401;   // LD  r2, DIR_Y
			8'd48: instruction = 16'h2250;   // ADD r1, r1, r2          ; y = y + dir_y
			8'd49: instruction = 16'hA1F3;   // ST  r1, BALL_Y
			8'd50: instruction = 16'h1601;   // LDI r3, 1
			8'd51: instruction = 16'h3658;   // SUB r3, r1, r3
			8'd52: instruction = 16'hC036;   // BNZ y_bot
			8'd53: instruction = 16'hA701;   // ST  r7, DIR_Y           ; y == 1 (top wall) -> go down
			8'd54: instruction = 16'h16BB;   // LDI r3, 187
			8'd55: instruction = 16'h3658;   // SUB r3, r1, r3
			8'd56: instruction = 16'hC03E;   // BNZ y_done              ; y != 187
			8'd57: instruction = 16'h98F0;   // LD  r4, MODE
			8'd58: instruction = 16'h3738;   // SUB r3, r4, r7
			8'd59: instruction = 16'hC000;   // BNZ start               ; Breakout: ball fell out -> restart the game
			8'd60: instruction = 16'h14FF;   // LDI r2, 0xFF
			8'd61: instruction = 16'hA201;   // ST  r2, DIR_Y           ; Pong: bounce off the bottom wall
			8'd62: instruction = 16'h92F0;   // LD  r1, MODE
			8'd63: instruction = 16'h3678;   // SUB r3, r1, r7
			8'd64: instruction = 16'hC092;   // BNZ brk                 ; mode != 1 -> Breakout code
			8'd65: instruction = 16'h92F1;   // LD  r1, CTRL
			8'd66: instruction = 16'h1404;   // LDI r2, 4
			8'd67: instruction = 16'h4650;   // AND r3, r1, r2
			8'd68: instruction = 16'h804B;   // BZ  p2_dn
			8'd69: instruction = 16'h98F5;   // LD  r4, PAD2
			8'd70: instruction = 16'h5B20;   // OR  r5, r4, r4
			8'd71: instruction = 16'h8054;   // BZ  p2_end
			8'd72: instruction = 16'h3938;   // SUB r4, r4, r7
			8'd73: instruction = 16'hA4F5;   // ST  r4, PAD2
			8'd74: instruction = 16'h7054;   // JMP p2_end
			8'd75: instruction = 16'h1408;   // LDI r2, 8
			8'd76: instruction = 16'h4650;   // AND r3, r1, r2
			8'd77: instruction = 16'h8054;   // BZ  p2_end
			8'd78: instruction = 16'h98F5;   // LD  r4, PAD2
			8'd79: instruction = 16'h14A7;   // LDI r2, 167
			8'd80: instruction = 16'h3B10;   // SUB r5, r4, r2
			8'd81: instruction = 16'h8054;   // BZ  p2_end
			8'd82: instruction = 16'h2938;   // ADD r4, r4, r7
			8'd83: instruction = 16'hA4F5;   // ST  r4, PAD2
			8'd84: instruction = 16'h92F2;   // LD  r1, BALL_X
			8'd85: instruction = 16'h9400;   // LD  r2, DIR_X
			8'd86: instruction = 16'h2250;   // ADD r1, r1, r2          ; x = x + dir_x
			8'd87: instruction = 16'hA1F2;   // ST  r1, BALL_X
			8'd88: instruction = 16'h160C;   // LDI r3, 12
			8'd89: instruction = 16'h3658;   // SUB r3, r1, r3
			8'd90: instruction = 16'hC067;   // BNZ pg_goal_l
			8'd91: instruction = 16'h98F3;   // LD  r4, BALL_Y
			8'd92: instruction = 16'h9AF4;   // LD  r5, PAD1
			8'd93: instruction = 16'h1C03;   // LDI r6, 3
			8'd94: instruction = 16'h2D30;   // ADD r6, r4, r6          ; ball bottom edge = y + 3
			8'd95: instruction = 16'h37A8;   // SUB r3, r6, r5
			8'd96: instruction = 16'hD091;   // BC  pg_done             ; bottom edge above paddle top -> miss
			8'd97: instruction = 16'h1C17;   // LDI r6, 23
			8'd98: instruction = 16'h2D70;   // ADD r6, r5, r6          ; paddle bottom edge = pad + 23
			8'd99: instruction = 16'h37A0;   // SUB r3, r6, r4
			8'd100: instruction = 16'hD091;   // BC  pg_done             ; paddle ends above ball top -> miss
			8'd101: instruction = 16'hA700;   // ST  r7, DIR_X           ; HIT -> ball goes right
			8'd102: instruction = 16'h7091;   // JMP pg_done
			8'd103: instruction = 16'h1602;   // LDI r3, 2
			8'd104: instruction = 16'h3658;   // SUB r3, r1, r3
			8'd105: instruction = 16'hC074;   // BNZ pg_right
			8'd106: instruction = 16'h94F7;   // LD  r2, SCORE2
			8'd107: instruction = 16'h24B8;   // ADD r2, r2, r7
			8'd108: instruction = 16'hA2F7;   // ST  r2, SCORE2
			8'd109: instruction = 16'h1478;   // LDI r2, 120
			8'd110: instruction = 16'hA2F2;   // ST  r2, BALL_X          ; serve from the middle, to the right
			8'd111: instruction = 16'h145A;   // LDI r2, 90
			8'd112: instruction = 16'hA2F3;   // ST  r2, BALL_Y
			8'd113: instruction = 16'hA700;   // ST  r7, DIR_X
			8'd114: instruction = 16'hA701;   // ST  r7, DIR_Y
			8'd115: instruction = 16'h7091;   // JMP pg_done
			8'd116: instruction = 16'h16F0;   // LDI r3, 240
			8'd117: instruction = 16'h3658;   // SUB r3, r1, r3
			8'd118: instruction = 16'hC084;   // BNZ pg_goal_r
			8'd119: instruction = 16'h98F3;   // LD  r4, BALL_Y
			8'd120: instruction = 16'h9AF5;   // LD  r5, PAD2
			8'd121: instruction = 16'h1C03;   // LDI r6, 3
			8'd122: instruction = 16'h2D30;   // ADD r6, r4, r6
			8'd123: instruction = 16'h37A8;   // SUB r3, r6, r5
			8'd124: instruction = 16'hD091;   // BC  pg_done
			8'd125: instruction = 16'h1C17;   // LDI r6, 23
			8'd126: instruction = 16'h2D70;   // ADD r6, r5, r6
			8'd127: instruction = 16'h37A0;   // SUB r3, r6, r4
			8'd128: instruction = 16'hD091;   // BC  pg_done
			8'd129: instruction = 16'h14FF;   // LDI r2, 0xFF
			8'd130: instruction = 16'hA200;   // ST  r2, DIR_X           ; HIT -> ball goes left
			8'd131: instruction = 16'h7091;   // JMP pg_done
			8'd132: instruction = 16'h16FA;   // LDI r3, 250
			8'd133: instruction = 16'h3658;   // SUB r3, r1, r3
			8'd134: instruction = 16'hC091;   // BNZ pg_done
			8'd135: instruction = 16'h94F6;   // LD  r2, SCORE1
			8'd136: instruction = 16'h24B8;   // ADD r2, r2, r7
			8'd137: instruction = 16'hA2F6;   // ST  r2, SCORE1
			8'd138: instruction = 16'h1478;   // LDI r2, 120
			8'd139: instruction = 16'hA2F2;   // ST  r2, BALL_X          ; serve from the middle, to the left
			8'd140: instruction = 16'h145A;   // LDI r2, 90
			8'd141: instruction = 16'hA2F3;   // ST  r2, BALL_Y
			8'd142: instruction = 16'h14FF;   // LDI r2, 0xFF
			8'd143: instruction = 16'hA200;   // ST  r2, DIR_X
			8'd144: instruction = 16'hA701;   // ST  r7, DIR_Y
			8'd145: instruction = 16'h700F;   // JMP main
			8'd146: instruction = 16'h92F2;   // LD  r1, BALL_X
			8'd147: instruction = 16'h9400;   // LD  r2, DIR_X
			8'd148: instruction = 16'h2250;   // ADD r1, r1, r2
			8'd149: instruction = 16'hA1F2;   // ST  r1, BALL_X
			8'd150: instruction = 16'h16FB;   // LDI r3, 251
			8'd151: instruction = 16'h3658;   // SUB r3, r1, r3
			8'd152: instruction = 16'hC09C;   // BNZ bk_lw
			8'd153: instruction = 16'h14FF;   // LDI r2, 0xFF
			8'd154: instruction = 16'hA200;   // ST  r2, DIR_X           ; right wall -> go left
			8'd155: instruction = 16'h709F;   // JMP bk_pad
			8'd156: instruction = 16'h5648;   // OR  r3, r1, r1
			8'd157: instruction = 16'hC09F;   // BNZ bk_pad              ; x != 0
			8'd158: instruction = 16'hA700;   // ST  r7, DIR_X           ; left wall -> go right
			8'd159: instruction = 16'h9401;   // LD  r2, DIR_Y
			8'd160: instruction = 16'h36B8;   // SUB r3, r2, r7
			8'd161: instruction = 16'hC0B7;   // BNZ bk_bricks           ; moving up -> skip
			8'd162: instruction = 16'h98F3;   // LD  r4, BALL_Y
			8'd163: instruction = 16'h16AD;   // LDI r3, 173
			8'd164: instruction = 16'h3718;   // SUB r3, r4, r3
			8'd165: instruction = 16'hD0B7;   // BC  bk_bricks           ; y < 173 : not at paddle height yet
			8'd166: instruction = 16'h16B3;   // LDI r3, 179
			8'd167: instruction = 16'h36E0;   // SUB r3, r3, r4
			8'd168: instruction = 16'hD0B7;   // BC  bk_bricks           ; y > 179 : already below the paddle
			8'd169: instruction = 16'h9AF2;   // LD  r5, BALL_X
			8'd170: instruction = 16'h9CF4;   // LD  r6, PAD1
			8'd171: instruction = 16'h1603;   // LDI r3, 3
			8'd172: instruction = 16'h2758;   // ADD r3, r5, r3          ; ball right edge = x + 3
			8'd173: instruction = 16'h36F0;   // SUB r3, r3, r6
			8'd174: instruction = 16'hD0B7;   // BC  bk_bricks           ; right edge left of paddle -> miss
			8'd175: instruction = 16'h161D;   // LDI r3, 29
			8'd176: instruction = 16'h2798;   // ADD r3, r6, r3          ; paddle right edge = pad + 29
			8'd177: instruction = 16'h36E8;   // SUB r3, r3, r5
			8'd178: instruction = 16'hD0B7;   // BC  bk_bricks           ; paddle ends before ball -> miss
			8'd179: instruction = 16'h14FF;   // LDI r2, 0xFF
			8'd180: instruction = 16'hA201;   // ST  r2, DIR_Y           ; HIT -> go up
			8'd181: instruction = 16'h14AC;   // LDI r2, 172
			8'd182: instruction = 16'hA2F3;   // ST  r2, BALL_Y
			8'd183: instruction = 16'h9401;   // LD  r2, DIR_Y
			8'd184: instruction = 16'h36B8;   // SUB r3, r2, r7
			8'd185: instruction = 16'h80DD;   // BZ  bk_win              ; moving down -> no brick check
			8'd186: instruction = 16'h98F3;   // LD  r4, BALL_Y
			8'd187: instruction = 16'h1611;   // LDI r3, 17
			8'd188: instruction = 16'h3718;   // SUB r3, r4, r3
			8'd189: instruction = 16'hD0DD;   // BC  bk_win              ; y < 17
			8'd190: instruction = 16'h161B;   // LDI r3, 27
			8'd191: instruction = 16'h36E0;   // SUB r3, r3, r4
			8'd192: instruction = 16'hD0DD;   // BC  bk_win              ; y > 27
			8'd193: instruction = 16'h9AF2;   // LD  r5, BALL_X
			8'd194: instruction = 16'h9CF8;   // LD  r6, BRICKS
			8'd195: instruction = 16'h53F8;   // OR  r1, r7, r7          ; r1 = brick bit mask, starts at 1
			8'd196: instruction = 16'h140A;   // LDI r2, 10              ; r2 = left edge of the current brick
			8'd197: instruction = 16'h4788;   // AND r3, r6, r1
			8'd198: instruction = 16'h80D8;   // BZ  bk_next             ; this brick is already gone
			8'd199: instruction = 16'h1803;   // LDI r4, 3
			8'd200: instruction = 16'h2960;   // ADD r4, r5, r4          ; ball right edge
			8'd201: instruction = 16'h3910;   // SUB r4, r4, r2
			8'd202: instruction = 16'hD0D8;   // BC  bk_next             ; ball is left of this brick
			8'd203: instruction = 16'h181A;   // LDI r4, 26
			8'd204: instruction = 16'h28A0;   // ADD r4, r2, r4          ; brick right edge
			8'd205: instruction = 16'h3928;   // SUB r4, r4, r5
			8'd206: instruction = 16'hD0D8;   // BC  bk_next             ; ball is right of this brick
			8'd207: instruction = 16'h6D88;   // XOR r6, r6, r1          ; HIT: clear the brick bit
			8'd208: instruction = 16'hA6F8;   // ST  r6, BRICKS
			8'd209: instruction = 16'hA701;   // ST  r7, DIR_Y           ; bounce down
			8'd210: instruction = 16'h181C;   // LDI r4, 28
			8'd211: instruction = 16'hA4F3;   // ST  r4, BALL_Y
			8'd212: instruction = 16'h98F6;   // LD  r4, SCORE1
			8'd213: instruction = 16'h2938;   // ADD r4, r4, r7
			8'd214: instruction = 16'hA4F6;   // ST  r4, SCORE1
			8'd215: instruction = 16'h70DD;   // JMP bk_win
			8'd216: instruction = 16'h181E;   // LDI r4, 30
			8'd217: instruction = 16'h24A0;   // ADD r2, r2, r4          ; next brick is 30 pixels further right
			8'd218: instruction = 16'h2248;   // ADD r1, r1, r1          ; mask <<= 1  (becomes 0 after brick 7)
			8'd219: instruction = 16'h80DD;   // BZ  bk_win
			8'd220: instruction = 16'h70C5;   // JMP bk_loop
			8'd221: instruction = 16'h9CF8;   // LD  r6, BRICKS
			8'd222: instruction = 16'h5DB0;   // OR  r6, r6, r6
			8'd223: instruction = 16'h8000;   // BZ  start
			8'd224: instruction = 16'h700F;   // JMP main
			default: instruction = 16'h0000;   // NOP
		endcase
	end

endmodule

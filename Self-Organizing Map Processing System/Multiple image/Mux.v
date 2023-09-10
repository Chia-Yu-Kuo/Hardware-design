module Mux (i0,i1,i2,i3,i4,i5,i6,i7,i8,i9, 
            i10,i11,i12,i13,i14,i15,i16,i17,i18,i19, 
            i20,i21,i22,i23,i24,i25,i26,i27,i28,i29, 
            i30,i31,i32,i33,i34,i35,i36,i37,i38,i39, 
            i40,i41,i42,i43,i44,i45,i46,i47,i48,i49, 
            i50,i51,i52,i53,i54,i55,i56,i57,i58,i59, 
            i60,i61,i62,i63,  sel,o);
    input [23:0] i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,i32,i33,i34,i35,i36,i37,i38,i39,i40,i41,i42,i43,i44,i45,i46,i47,i48,i49,i50,i51,i52,i53,i54,i55,i56,i57,i58,i59,i60,i61,i62,i63;
    input [5:0] sel;
    output [23:0] o;

    assign o =  (sel==6'd63) ? i63 : 
                (sel==6'd62) ? i62 :
                (sel==6'd61) ? i61 :
                (sel==6'd60) ? i60 :
                (sel==6'd59) ? i59 :
                (sel==6'd58) ? i58 :
                (sel==6'd57) ? i57 :
                (sel==6'd56) ? i56 :
                (sel==6'd55) ? i55 :
                (sel==6'd54) ? i54 :
                (sel==6'd53) ? i53 :
                (sel==6'd52) ? i52 :
                (sel==6'd51) ? i51 :
                (sel==6'd50) ? i50 :
                (sel==6'd49) ? i49 :
                (sel==6'd48) ? i48 :
                (sel==6'd47) ? i47 :
                (sel==6'd46) ? i46 :
                (sel==6'd45) ? i45 :
                (sel==6'd44) ? i44 :
                (sel==6'd43) ? i43 :
                (sel==6'd42) ? i42 :
                (sel==6'd41) ? i41 :
                (sel==6'd40) ? i40 :
                (sel==6'd39) ? i39 :
                (sel==6'd38) ? i38 :
                (sel==6'd37) ? i37 :
                (sel==6'd36) ? i36 :
                (sel==6'd35) ? i35 :
                (sel==6'd34) ? i34 :
                (sel==6'd33) ? i33 :
                (sel==6'd32) ? i32 :
                (sel==6'd31) ? i31 :
                (sel==6'd30) ? i30 :
                (sel==6'd29) ? i29 :
                (sel==6'd28) ? i28 :
                (sel==6'd27) ? i27 :
                (sel==6'd26) ? i26 :
                (sel==6'd25) ? i25 :
                (sel==6'd24) ? i24 :
                (sel==6'd23) ? i23 :
                (sel==6'd22) ? i22 :
                (sel==6'd21) ? i21 :
                (sel==6'd20) ? i20 :
                (sel==6'd19) ? i19 :
                (sel==6'd18) ? i18 :
                (sel==6'd17) ? i17 :
                (sel==6'd16) ? i16 :
                (sel==6'd15) ? i15 :
                (sel==6'd14) ? i14 :
                (sel==6'd13) ? i13 :
                (sel==6'd12) ? i12 :
                (sel==6'd11) ? i11 :
                (sel==6'd10) ? i10 :
                (sel==6'd9)  ? i9  :
                (sel==6'd8)  ? i8  :
                (sel==6'd7)  ? i7  :
                (sel==6'd6)  ? i6  :
                (sel==6'd5)  ? i5  :
                (sel==6'd4)  ? i4  :
                (sel==6'd3)  ? i3  :
                (sel==6'd2)  ? i2  :
                (sel==6'd1)  ? i1  : i0 ;

 
endmodule
IMPLEMENTATION MODULE VESA;

IMPORT SYSTEM, Lib, IO, Str;

PROCEDURE get_version( VAR VESA_Info :VbeInfoBlock; VAR MajorVer, MinorVer :INTEGER ) :INTEGER;
     VAR regs :SYSTEM.Registers;
         ver  :INTEGER;
         m    :INTEGER;
BEGIN
    Lib.Fill( ADR(VESA_Info), 512, 0 );
    VESA_Info.Vbe_Signature := VBE2_Sig;

    regs.AX := 04F00H;
    regs.ES := Seg(VESA_Info);
    regs.DI := Ofs(VESA_Info);
    Lib.Intr( regs, 010H );

    IF (regs.AX # 004FH) OR
       (VESA_Info.Vbe_Signature # VESA_Sig )
     THEN
       RETURN 0;
     ELSE
       ver      := VESA_Info.Vbe_Version;
       MajorVer := (ver >> 8);
       m        := (ver & 0FFH);
       IF ((m # 0) & ((m & 0FH) # 0)) THEN
          MinorVer := m * 10;
        ELSE
          MinorVer := (m >> 4) * 10;
       END; (* if *)
    END; (* if *)
    RETURN ver;
END get_version;

PROCEDURE check_mode( Mode_Num :INTEGER; VAR MODE_Info :ModeInfoBlock ) :INTEGER;
    VAR regs :SYSTEM.Registers;
BEGIN
    Lib.Fill( ADR(MODE_Info), 256, 0 );

    regs.AX := 04F01H;
    regs.CX := Mode_Num;
    regs.ES := Seg( MODE_Info );
    regs.DI := Ofs( MODE_Info );
    Lib.Intr( regs, 010H );

    IF regs.AX # 004FH THEN
       RETURN 0;
     ELSE
       RETURN Mode_Num;
    END; (* if *)
END check_mode;

PROCEDURE set_mode( Mode_Num :INTEGER ) :INTEGER;
    VAR regs :SYSTEM.Registers;
BEGIN
    regs.AX := 04F02H;
    regs.BX := Mode_Num;
    Lib.Intr( regs, 010H );

    IF regs.AX # 004FH THEN
       IO.WrStr( 'Error attempting to set Mode ' );
       IO.WrHex( Mode_Num, 1 );
       IO.WrStr( 'H.' );
       IO.WrLn();
       RETURN 0;
     ELSE
       RETURN Mode_Num;
    END; (* if *)
END set_mode;

PROCEDURE mode_info(     _mode   :CARDINAL;
                     VAR _type   :ARRAY OF CHAR;
                     VAR _x_res  :CARDINAL;
                     VAR _y_res  :CARDINAL;
                     VAR _colors :LONGCARD ) :BOOLEAN;

    TYPE MODE_INFO_TYPE = RECORD
              mode   :CARDINAL;
              type   :ARRAY [ 0..7 ] OF CHAR;
              max_x  :CARDINAL;
              max_y  :CARDINAL;
              colors :LONGCARD;
         END; (* MODE_INFO_TYPE *)
         MODES_INFO_TYPE = ARRAY [ 0..27 ] OF MODE_INFO_TYPE;

     CONST MODE_INFO = MODES_INFO_TYPE(
             MODE_INFO_TYPE( 100H, "GRAPHICS",  640,  400,      256 ),
             MODE_INFO_TYPE( 101H, "GRAPHICS",  640,  480,      256 ),
             MODE_INFO_TYPE( 102H, "GRAPHICS",  800,  600,       16 ),
             MODE_INFO_TYPE( 103H, "GRAPHICS",  800,  600,      256 ),
             MODE_INFO_TYPE( 104H, "GRAPHICS", 1024,  768,       16 ),
             MODE_INFO_TYPE( 105H, "GRAPHICS", 1024,  768,      256 ),
             MODE_INFO_TYPE( 106H, "GRAPHICS", 1280, 1024,       16 ),
             MODE_INFO_TYPE( 107H, "GRAPHICS", 1280, 1024,      256 ),
             MODE_INFO_TYPE( 108H, "TEXT    ",   80,   60,       16 ),
             MODE_INFO_TYPE( 109H, "TEXT    ",  132,   25,       16 ),
             MODE_INFO_TYPE( 10AH, "TEXT    ",  132,   43,       16 ),
             MODE_INFO_TYPE( 10BH, "TEXT    ",  132,   50,       16 ),
             MODE_INFO_TYPE( 10CH, "TEXT    ",  132,   60,       16 ),
             MODE_INFO_TYPE( 10DH, "GRAPHICS",  320,  200,    32767 ),
             MODE_INFO_TYPE( 10EH, "GRAPHICS",  320,  200,    65535 ),
             MODE_INFO_TYPE( 10FH, "GRAPHICS",  320,  200, 16777216 ),
             MODE_INFO_TYPE( 110H, "GRAPHICS",  640,  480,    32767 ),
             MODE_INFO_TYPE( 111H, "GRAPHICS",  640,  480,    65535 ),
             MODE_INFO_TYPE( 112H, "GRAPHICS",  640,  480, 16777216 ),
             MODE_INFO_TYPE( 113H, "GRAPHICS",  800,  600,    32767 ),
             MODE_INFO_TYPE( 114H, "GRAPHICS",  800,  600,    65535 ),
             MODE_INFO_TYPE( 115H, "GRAPHICS",  800,  600, 16777216 ),
             MODE_INFO_TYPE( 116H, "GRAPHICS", 1024,  768,    32767 ),
             MODE_INFO_TYPE( 117H, "GRAPHICS", 1024,  768,    65535 ),
             MODE_INFO_TYPE( 118H, "GRAPHICS", 1024,  768, 16777216 ),
             MODE_INFO_TYPE( 119H, "GRAPHICS", 1280, 1024,    32767 ),
             MODE_INFO_TYPE( 11AH, "GRAPHICS", 1280, 1024,    65535 ),
             MODE_INFO_TYPE( 11BH, "GRAPHICS", 1280, 1024, 16777216 )
           );

    VAR i     :CARDINAL;
        found :BOOLEAN;

BEGIN
    i := 0;
    WHILE ~ found & (i <= HIGH(MODE_INFO)) DO
       IF MODE_INFO[i].mode = _mode THEN
          found := TRUE;
          WITH MODE_INFO[i] DO
             Str.Copy( _type, type );
             _x_res  := max_x;
             _y_res  := max_y;
             _colors := colors;
          END; (* with *)
        ELSE
          INC(i);
       END; (* if *)
    END; (* while  *)
    RETURN found;
END mode_info;

END VESA.

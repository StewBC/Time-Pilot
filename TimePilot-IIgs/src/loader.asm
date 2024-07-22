;-----------------------------------------------------------------------------
; loader.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                      copy     src/globals.s
                      mcopy    src/loader.mac

LOADER                START

                      using    LOADERDATA

SCREEN_BASE_E1        gequ     $E12000
PALETTE_BASE_E1       gequ     $E19E00
SCB_E1                gequ     $E19D00

zNibCount             gequ     $00
zUserID               gequ     $02
zHandleL              gequ     $04
zHandleH              gequ     $06

                      phb
                      phk
                      plb

                      short    m
                      lda      #$E1
                      sta      SHR                   ; graphics ON
                      long     m

                      lda      #0                    ; clear the screen
                      ldx      #SCREEN_BYTES-2
siClr                 sta      SCREEN_BASE_E1,x
                      dex
                      dex
                      bpl      siClr

                      ldx      #$FE
siClearSCB            sta      SCB_E1,x              ; 19D00-19DFF set to 0
                      dex                            ; (Scan Control Bytes)
                      dex
                      bpl      siClearSCB
                      ldx      #30                   ; 16 colors, 2 byes each 0 based [0,31]
siPalloop             lda      dt_splash_palette,x
                      sta      PALETTE_BASE_E1,x
                      dex
                      dex
                      bpl      siPalloop             ; copy till 0/1 was written

                      lda      #SPLASH_DATA          ; set decom source
                      sta      GETSRC+1
                      lda      #SCREEN_BASE_E1       ; and dest
                      sta      PUTDST+1
                      short    m
                      lda      #^SPLASH_DATA         ; as 24 bit addresses
                      sta      GETSRC+3
                      lda      #^SCREEN_BASE_E1
                      sta      PUTDST+3
                      long     m
                      jsr      DECOMPRESS_LZSA2      ; decomp splash logo tol SHR
                      long     m,i

                      plb
                      _QuitGS  mQuitParameters       ; quit and load the actual game
mQuitParameters       dc       i2'2'
                      dc       a3'pathname'
                      dc       i4'0'

; -----------------------------------------------------------------------------
; Decompress raw LZSA2 block.
; Create one with lzsa -r -f2 <original_file> <compressed_file>
;
; in:
; * LZSA_SRC_LO/LZSA_SRC_HI/LZSA_SRC_BANK contain the compressed raw block address
; * LZSA_DST_LO/LZSA_DST_HI/LZSA_DST_BANK contain the destination buffer address
;
; out:
; * LZSA_DST_LO/LZSA_DST_HI/LZSA_DST_BANK contain the last decompressed byte address, +1
;
; -----------------------------------------------------------------------------
; Backward decompression is also supported, use lzsa -r -b -f2 <original_file> <compressed_file>
; To use it, also define BACKWARD_DECOMPRESS=1 before including this code!
;
; in:
; * LZSA_SRC_LO/LZSA_SRC_HI/LZSA_SRC_BANK must contain the address of the last byte of compressed data
; * LZSA_DST_LO/LZSA_DST_HI/LZSA_DST_BANK must contain the address of the last byte of the destination buffer
;
; out:
; * LZSA_DST_LO/LZSA_DST_HI/BANK contain the last decompressed byte address, -1
;
; -----------------------------------------------------------------------------
;
;  Copyright (C) 2019-2020 Emmanuel Marty, Peter Ferrie
;
;  This software is provided 'as-is', without any express or implied
;  warranty.  In no event will the authors be held liable for any damages
;  arising from the use of this software.
;
;  Permission is granted to anyone to use this software for any purpose,
;  including commercial applications, and to alter it and redistribute it
;  freely, subject to the following restrictions:
;
;  1. The origin of this software must not be misrepresented; you must not
;     claim that you wrote the original software. If you use this software
;     in a product, an acknowledgment in the product documentation would be
;     appreciated but is not required.
;  2. Altered source versions must be plainly marked as such, and must not be
;     misrepresented as being the original software.
;  3. This notice may not be removed or altered from any source distribution.
; -----------------------------------------------------------------------------

;zNibCount = $FC                          ; zero-page location for temp offset

DECOMPRESS_LZSA2      entry
                      short    m,i
                      LDY      #$00
                      STY      zNibCount

DECODE_TOKEN          anop
                      JSR      GETSRC                ; read token byte: XYZ|LL|MMM
                      PHA                            ; preserve token on stack

                      AND      #$18                  ; isolate literals count (LL)
                      BEQ      NO_LITERALS           ; skip if no literals to copy
                      CMP      #$18                  ; LITERALS_RUN_LEN_V2?
                      BCC      PREPARE_C_LITERALS    ; if less, count is directly embedded in token

                      JSR      GETNIBBLE             ; get extra literals length nibble
; add nibble to len from token
                      ADC      #$02                  ; (LITERALS_RUN_LEN_V2) minus carry
                      CMP      #$12                  ; LITERALS_RUN_LEN_V2 + 15 ?
                      BCC      PREPARE_CL_DIRECT     ; if less, literals count is complete

                      JSR      GETSRC                ; get extra byte of variable literals count
; the carry is always set by the CMP above
; GETSRC doesn't change it
                      SBC      #$EE                  ; overflow?
                      BRA      PREPARE_CL_DIRECT

PREPARE_CL_LARGE      anop
; handle 16 bits literals count
; literals count = directly these 16 bits
                      JSR      GETLARGESRC           ; grab low 8 bits in X, high 8 bits in A
                      TAY                            ; put high 8 bits in Y
                      BCS      PREPARE_CL_HIGH       ; (*same as JMP PREPARE_CL_HIGH but shorter)

PREPARE_C_LITERALS    anop
                      LSR      A                     ; shift literals count into place
                      LSR      A
                      LSR      A

PREPARE_CL_DIRECT     anop
                      TAX
                      BCS      PREPARE_CL_LARGE      ; if so, literals count is large

PREPARE_CL_HIGH       anop
                      TXA
                      BEQ      COPY_LITERALS
                      INY

COPY_LITERALS         anop
                      JSR      GETPUT                ; copy one byte of literals
                      DEX
                      BNE      COPY_LITERALS
                      DEY
                      BNE      COPY_LITERALS

NO_LITERALS           anop
                      PLA                            ; retrieve token from stack
                      PHA                            ; preserve token again
                      ASL      A
                      BCS      REPMATCH_OL_OFFSET    ; 1YZ: rep-match or 13/16 bit offset

                      ASL      A                     ; 0YZ: 5 or 9 bit offset
                      BCS      OFFSET_9_BIT

; 00Z: 5 bit offset

                      LDX      #$FF                  ; set offset bits 15-8 to 1

                      JSR      GETCOMBINEDBITS       ; rotate Z bit into bit 0, read nibble for bits 4-1
                      ORA      #$E0                  ; set bits 7-5 to 1
                      BNE      GOT_OFFSET_LO         ; go store low byte of match offset and prepare match

OFFSET_9_BIT          anop                           ; 01Z: 9 bit offset
;;ASL A                                  ; shift Z (offset bit 8) in place
                      ROL      A
                      ROL      A
                      AND      #$01
                      EOR      #$FF                  ; set offset bits 15-9 to 1
                      BNE      GOT_OFFSET_HI         ; go store high byte, read low byte of match offset and prepare match
; (*same as JMP GOT_OFFSET_HI but shorter)

REPMATCH_OL_OFFSET    anop
                      ASL      A                     ; 13 bit offset?
                      BCS      REPMATCH_OR_16_BIT    ; handle rep-match or 16-bit offset if not

; 10Z: 13 bit offset

                      JSR      GETCOMBINEDBITS       ; rotate Z bit into bit 8, read nibble for bits 12-9
                      ADC      #$DE                  ; set bits 15-13 to 1 and substract 2 (to substract 512)
                      BNE      GOT_OFFSET_HI         ; go store high byte, read low byte of match offset and prepare match
; (*same as JMP GOT_OFFSET_HI but shorter)

REPMATCH_OR_16_BIT    anop                           ; rep-match or 16 bit offset
;;ASL A                                  ; XYZ=111?
                      BMI      REP_MATCH             ; reuse previous offset if so (rep-match)

; 110: handle 16 bit offset
                      JSR      GETSRC                ; grab high 8 bits
GOT_OFFSET_HI         anop
                      TAX
                      JSR      GETSRC                ; grab low 8 bits
GOT_OFFSET_LO         anop
                      STA      OFFSLO+1              ; store low byte of match offset
                      STX      OFFSLO+2              ; store high byte of match offset

; Forward decompression - add match offset
REP_MATCH             anop
                      CLC                            ; add dest + match offset
                      long     m
                      LDA      PUTDST+1              ; 16 bits
OFFSLO                anop
                      ADC      #$AAAA
                      STA      COPY_MATCH_LOOP+1     ; store back reference address
                      short    m

                      LDA      PUTDST+3              ; bank
                      STA      COPY_MATCH_LOOP+3     ; store back reference address

                      PLA                            ; retrieve token from stack again
                      AND      #$07                  ; isolate match len (MMM)
                      ADC      #$01                  ; add MIN_MATCH_SIZE_V2 and carry
                      CMP      #$09                  ; MIN_MATCH_SIZE_V2 + MATCH_RUN_LEN_V2?
                      BCC      PREPARE_COPY_MATCH    ; if less, length is directly embedded in token

                      JSR      GETNIBBLE             ; get extra match length nibble
; add nibble to len from token
                      ADC      #$08                  ; (MIN_MATCH_SIZE_V2 + MATCH_RUN_LEN_V2) minus carry
                      CMP      #$18                  ; MIN_MATCH_SIZE_V2 + MATCH_RUN_LEN_V2 + 15?
                      BCC      PREPARE_COPY_MATCH    ; if less, match length is complete

                      JSR      GETSRC                ; get extra byte of variable match length
; the carry is always set by the CMP above
; GETSRC doesn't change it
                      SBC      #$E8                  ; overflow?

PREPARE_COPY_MATCH    anop
                      TAX
                      BCC      PREPARE_COPY_MATCH_Y  ; if not, the match length is complete
                      BEQ      DECOMPRESSION_DONE    ; if EOD code, bail

; Handle 16 bits match length
                      JSR      GETLARGESRC           ; grab low 8 bits in X, high 8 bits in A
                      TAY                            ; put high 8 bits in Y

PREPARE_COPY_MATCH_Y  anop
                      TXA
                      BEQ      COPY_MATCH_LOOP
                      INY

COPY_MATCH_LOOP       anop
                      LDA      $AAAAAA               ; get one byte of backreference
                      JSR      PUTDST                ; copy to destination

                      long     m
; Forward decompression -- put backreference bytes forward
                      INC      COPY_MATCH_LOOP+1
                      short    m

                      DEX
                      BNE      COPY_MATCH_LOOP
                      DEY
                      BNE      COPY_MATCH_LOOP
                      JMP      DECODE_TOKEN

GETCOMBINEDBITS       anop
                      EOR      #$80
                      ASL      A
                      PHP

                      JSR      GETNIBBLE             ; get nibble into bits 0-3 (for offset bits 1-4)
                      PLP                            ; merge Z bit as the carry bit (for offset bit 0)
COMBINEDBITZ          anop
                      ROL      A                     ; nibble -> bits 1-4; carry(!Z bit) -> bit 0 ; carry cleared
DECOMPRESSION_DONE    anop
                      RTS

GETNIBBLE             anop
NIBBLES               anop
                      LDA      #$AA
                      LSR      zNibCount
                      BCC      NEED_NIBBLES
                      AND      #$0F                  ; isolate low 4 bits of nibble
                      RTS

NEED_NIBBLES          anop
                      INC      zNibCount
                      JSR      GETSRC                ; get 2 nibbles
                      STA      NIBBLES+1
                      LSR      A
                      LSR      A
                      LSR      A
                      LSR      A
                      SEC
                      RTS

; Forward decompression -- get and put bytes forward

GETPUT                anop
                      JSR      GETSRC
PUTDST                anop
LZSA_DST_LO           anop
                      STA      $AAAAAA
                      long     m
                      INC      PUTDST+1
                      short    m
                      RTS

GETLARGESRC           anop
                      JSR      GETSRC                ; grab low 8 bits
                      TAX                            ; move to X
; fall through grab high 8 bits

GETSRC                anop
LZSA_SRC_LO           anop
                      LDA      $AAAAAA
                      long     m
                      INC      GETSRC+1
                      short    m
                      RTS

                      END

LOADERDATA            DATA
pathname              dc       i2'6',c'1/GAME'

SPLASH_DATA           dc       h'0F00FFE9F3055F0F06666662853C1B60'
                      dc       h'00166042574754F07741625910061166'
                      dc       h'00BF106111209F47617749116203FF52'
                      dc       h'1600596024EF60750F11F06D16254761'
                      dc       h'FF74EE61662667C17647612F4A016087'
                      dc       h'84F1794760F402214F6061F27D7F1220'
                      dc       h'220060C2F98228227F0F202066C1764F'
                      dc       h'0661356922C0110660A7FF457C0922F3'
                      dc       h'5F60200202166061FD7DE912692020B7'
                      dc       h'10117AF3734761E862FF2F0260220101'
                      dc       h'73EA6686DD2A41616120971016C8FD73'
                      dc       h'87CA6F601E6866C18F6083FF7DB22000'
                      dc       h'4300FFB72166E4F67F034061AF16FF45'
                      dc       h'81621BB76216EF6771F766612F020801'
                      dc       h'BF5706116172EF114E83048F11EFA570'
                      dc       h'570666613F1410225F0F260016626F4E'
                      dc       h'61660B00DF0D226722FD6C5266666246'
                      dc       h'610B008901DE2587A5FC6E642886F201'
                      dc       h'49F121110A0187EFA5650D66FC87F51E'
                      dc       h'44618C0209037F571660646202BF4E01'
                      dc       h'6606416121C203480061EF21FC586D06'
                      dc       h'CCA2CA60D5E86007F7005E83A9220F69'
                      dc       h'02226730586F62D62F700606DE07EF69'
                      dc       h'021C6F62224D0F66F1477C6A6F20C106'
                      dc       h'210008200E87A5F6474F066B6735BE47'
                      dc       h'616902BE8920CF4A6735504761EEEF02'
                      dc       h'254F6F16C5420F22FF0A42D5475DD625'
                      dc       h'57216060F864A4B3A7FBDE066BA72DFF'
                      dc       h'444F62610B300220E5E862276F436166'
                      dc       h'C1671F6161C4A902C8C48A0645A7FECC'
                      dc       h'57160060F161FB20000100E901475F2E'
                      dc       h'A44B67C11F671F5A4661AC16DF9AAA01'
                      dc       h'F4776102C12FEF224D86DE384F626149'
                      dc       h'1160ED225F0A261120618F229F0F4DEC'
                      dc       h'064F02617C54116260E812A218A6FC3B'
                      dc       h'EE2087E7FE504E066D465A61D04361A7'
                      dc       h'7C0C02079167C1FF48170666636F62C8'
                      dc       h'05F54161071444616D2022672147ADE3'
                      dc       h'67A7074A4772E7AF604965A68987D51A'
                      dc       h'4C206125AC4E026024770022216D47AD'
                      dc       h'9766665C5D4760B5A7A03726475E8CA7'
                      dc       h'2167270B81806D0221224EA2574760E8'
                      dc       h'475E4760F023671F671BE06F01C1AA20'
                      dc       h'BFDF6B02B8858467217C47AD4F615F34'
                      dc       h'16611667C0D06720EE11176555F90003'
                      dc       h'67C1B40006CABD4267EA202181D62A62'
                      dc       h'1B476047ADCA4A565E8B60434260265D'
                      dc       h'47600F6502267D475FA6EF66E96166D1'
                      dc       h'64C143538A0081EF006E470D48565F8B'
                      dc       h'163FA5576660602FAE61FA4EB1001062'
                      dc       h'8F60C15C6E02282C026E4760475F9FAC'
                      dc       h'61824760FA30868650001161F721600E'
                      dc       h'8E00A6AD22FEE24760475F8961C38368'
                      dc       h'6720FB30430A4360A910EA66C2AF20E3'
                      dc       h'66AF00FCE147ADE7F2611681136720FD'
                      dc       h'2D2C56819DAB813362E5A7B2D8A7E166'
                      dc       h'4F0260F6132C564F5660FC2F46DBE862'
                      dc       h'83E66522A7E55A45AA228F5721066008'
                      dc       h'25CF67202E266E50616660ED0146610A'
                      dc       h'024E0260E820E901EF10FD08ED65EF56'
                      dc       h'8682F94760A4DFE547600741BB01ED66'
                      dc       h'C82203D70485BBEEAA11A84760F327A6'
                      dc       h'E047601185BB6773E147BBB601168FA0'
                      dc       h'A7E23F4D00614560EF0061BB0F166160'
                      dc       h'5661C324F8863161CD55622260FF1F20'
                      dc       h'0066602A6220EF6609234760FE0B6A00'
                      dc       h'D5EA028F20AD31416156611260A7393E'
                      dc       h'8700EE87461C672047CAEF47600B6523'
                      dc       h'A7E76DA25F486C22C0AA10404760F261'
                      dc       h'476CA7B229A21B34A7980F476065EF02'
                      dc       h'06A33547611EA74F4C4F169684FFAE67'
                      dc       h'2026A6C50005069EA75F0A87001C64D1'
                      dc       h'66C285DF4760FB058B6111A7F6E04760'
                      dc       h'FB17A6CB47AD32479FAE627FAB752112'
                      dc       h'3164234B02574F22600BF71165F4436E'
                      dc       h'16C2F11112A46BE9608C00B6FB214760'
                      dc       h'FF2A624F476002A5BE7C67C062C18D02'
                      dc       h'F58482A24160628D84B358028C01AB6E'
                      dc       h'A44A67C0DFEF1603C6DAED87D637679C'
                      dc       h'8647604E16B366C26633A9100C6DA961'
                      dc       h'8D8E20D4162B105C0D2616119A476087'
                      dc       h'CEE087230257166660FC14AC11002057'
                      dc       h'A324A2056D8C2673B12102B70F891037'
                      dc       h'A66BCD64C14E219A6F60C023ACA7A0A4'
                      dc       h'4561A5AF4760FB11465FAC561B4B2162'
                      dc       h'214C4E62608F02D3046D01A9AC614943'
                      dc       h'5F4760EB8F5660C8212043034760F417'
                      dc       h'5411666DA27502A9A6E88B10EC9DA1AC'
                      dc       h'835B86ED0042C245816F60C0A6E9F226'
                      dc       h'468408068FED654F61601406FC726221'
                      dc       h'C48413A442F6B22100C29711105486B7'
                      dc       h'2616A25747607B475246844A6161465F'
                      dc       h'4760F912A74C406A65E7637953566260'
                      dc       h'0083D9AA8A11A3EC00479A2C57116060'
                      dc       h'47B10147606696067F67C006470DDB07'
                      dc       h'526A561FA109AB60FACBAE10DD4660A5'
                      dc       h'FDAC87C0FF11458A064760FA23866FA9'
                      dc       h'62457E6111416041D8A7481B6565A667'
                      dc       h'A7D68047608CA7C4ECA700AF67C01146'
                      dc       h'A2F2222660C04F216139972216B65A87'
                      dc       h'80F01067C14684A7B8204760F018FC55'
                      dc       h'6665A2F3205760226047050F4F566010'
                      dc       h'A7E86E4F5660FF280664494F62603E82'
                      dc       h'04869F1D476010AF1689AAA7A7404760'
                      dc       h'FF1E8673A60F4F4C16114D16BD47600F'
                      dc       h'EF61A787408F47602C562165C94760F7'
                      dc       h'16EF65EF56FF75EF1150EF615FEF560F'
                      dc       h'AF167A294760FF34EE66F7165525829F'
                      dc       h'0A47603CEF56FE278F65AA1F6F16C028'
                      dc       h'AE56AECC87162FAF56410AA6A94760FF'
                      dc       h'1A468E465447601987EB66A6CF2EA641'
                      dc       h'47717C8776BE67C0867FF74F16601F67'
                      dc       h'7CB0264660EF61FE0BEF61468F009F47'
                      dc       h'6042F71655F909F76611F716559FF755'
                      dc       h'615DF76611FD138720EF0CBB44D12E6B'
                      dc       h'9B0529B660EE16268EB6DF220EBB47CA'
                      dc       h'5406A3B6290617B616B645604F6BC56C'
                      dc       h'8FB6407F0C77A499F22D6706B66A76C0'
                      dc       h'2621A50B6785BA632A6787342F4F67B3'
                      dc       h'34A3680E116B1776166045604E678F06'
                      dc       h'4760BE264760F21B874F49462187F30D'
                      dc       h'47604677430347607B87607F0F882B17'
                      dc       h'6168614A86BD0621A50B6885BA632347'
                      dc       h'604A46C185331F066444460B17861646'
                      dc       h'46DB478F46D34760FA26A32E57216860'
                      dc       h'328362479218035F0D4444336047043F'
                      dc       h'4760362604627B4F886022A247600944'
                      dc       h'FE5743336047BB112345C567C0EF0FAA'
                      dc       h'2B17616A616AA6200621A02647C9136C'
                      dc       h'66C1020FA602134333F04F46CEECA646'
                      dc       h'DA06E507DF4FA6602924B406219F4760'
                      dc       h'81AAA69F3C4FAA6027EF61F23947C828'
                      dc       h'665F476015EF16FA4C67FA4F6160FF21'
                      dc       h'F7A6113A4F169B9F67C00E4725AF4FA1'
                      dc       h'603A67BF9F4F616010EF618FF7616102'
                      dc       h'8794920F60B64A066026688789342720'
                      dc       h'05EF062247600E60004F16D8478C3606'
                      dc       h'45C5067F47602C0690064760F811C7DC'
                      dc       h'FE57611660F23DF71660F76611FE1156'
                      dc       h'6461C646C57064467267C0F71160FF1F'
                      dc       h'465F46614760134672067DA1F2611F67'
                      dc       h'2071064760F41D86E3CE60CD4F4760F2'
                      dc       h'144172CF66C2845F17166443344D8F60'
                      dc       h'F1C987B39F07B862C0266A21EF661945'
                      dc       h'5E2740064760204E66ADEF1648647242'
                      dc       h'5F4661415040D6F64461866060473107'
                      dc       h'FF3C67C00107B44864722183A69C4324'
                      dc       h'4964D6EF346F602C1F47605B75334467'
                      dc       h'2A61D761C1224760EF170666F13C4660'
                      dc       h'07B06964D14771921664B7D822C7D685'
                      dc       h'FF010F44F13B456007D34571831D2A64'
                      dc       h'9F445F0724EF004A04B007FF5246714A'
                      dc       h'46620F443A4A4061475DFE6A64B54763'
                      dc       h'475DFE6E4763475DFE78476367BAEF47'
                      dc       h'6380465DEF44F0574763475DFE7C87B3'
                      dc       h'0F475D6E4763EF475D214763FF82465D'
                      dc       h'4F436374A7EEE94763FF40475D7C4E34'
                      dc       h'63475DFE6E8717EF475D6F4763EF475D'
                      dc       h'434763FD7487A3EF476374475DEF4763'
                      dc       h'74475DEF476318475DFF7C47635387DE'
                      dc       h'A3A7EF7A2F87EF8C4B4763EF475D6E47'
                      dc       h'63EF475D7347639F475D794763FF8046'
                      dc       h'5D574333638066BC0F00FFE9C60A4FCC'
                      dc       h'BEFC27F10CCC32CCC0029A45ABEEC026'
                      dc       h'46D42AC0EF47AF064FC060FD3549CCAF'
                      dc       h'280C23CD004DCC9D4FCC908305228F67'
                      dc       h'C0164CCCA4677EFC234AC0C022466822'
                      dc       h'8343A863AC63A4476066B8056A2A0C01'
                      dc       h'4624667400E147B44760FC2545202447'
                      dc       h'AC1E2601C02347602025663122A0425C'
                      dc       h'653426213F47602C540CCC8023CF84A4'
                      dc       h'22C54760F7CCCC7467C022020320CC47'
                      dc       h'6062906722FF22635CA5ED6720C52267'
                      dc       h'207B046680042D2367C07F433867C022'
                      dc       h'64CC66C46720492386FF94A740502224'
                      dc       h'66455044722246D0662C455C87EF483D'
                      dc       h'EFCCEF47900507DFE7F9020555502D50'
                      dc       h'0C55B9260635074A4F5060F70EE0F040'
                      dc       h'FE55005523CF476009EF05FE5763BC31'
                      dc       h'555027C0E855242435050526E044342D'
                      dc       h'05382E0EEEEE00EE22CF67C040468C63'
                      dc       h'3422C9026528425823A24D553846DC6F'
                      dc       h'55282DEEEF877EF541448C437465E447'
                      dc       h'6067A4182367C06F47604667EC6C2367'
                      dc       h'C033EA5005224A06250F6FEEC04A87F4'
                      dc       h'AC67C07C2263C824E222240667C083FF'
                      dc       h'8007F5E92F02E8DD0712F50DD02DD027'
                      dc       h'8227F62A0D6106570DD060FC4244A346'
                      dc       h'602625264444478027284760FF482033'
                      dc       h'DDD0CE32DDDD4760282E0D23A8252521'
                      dc       h'F2000045CC08D0242D20238F67203573'
                      dc       h'0DDDB8655826C624254A2400F8244564'
                      dc       h'262C02001B0446B467C0F036476062F0'
                      dc       h'47605824240A0122856627476065804B'
                      dc       h'D00C4760FC4026242F857E67C04A46C8'
                      dc       h'476047140FA740FF35644E66C886B024'
                      dc       h'2823266F87803426436447C83345B4A7'
                      dc       h'FAFFE94508E7E8'

; palette is gb0r
dt_splash_palette     dc       h'0000FF0FCF001A00'
                      dc       h'0500F00F66060008'
                      dc       h'0007000500043005'
                      dc       h'5F00800f000f0000'
                      END

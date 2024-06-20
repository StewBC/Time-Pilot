;-----------------------------------------------------------------------------
; macros
            macro
&l          LDSCRNXY &x,&y
&l          ldy      #$2000+&x*4+(&y*8*160)
            mend
            macro
&l          LDAPAL   &a
&l          lda      #&a|12+&a|8+&a|4+&a
            mend
            macro
&l          LDBOX    &x,&y,&w,&h
&l          ldx      #(&x+&w)*4-2+(((&y+&h)*8)-1)*160
            ldy      #&w*2
            lda      #&h*8
            mend
            macro
&l          LDXPRXY  &x,&y
&l          ldx      #&x*4+(&y*8*160)
            mend
            macro
&l          PRINTSZ  &a,&x,&y
&l          lda      #^&a
            ldy      #|&a
            ldx      #&x*4+(&y*8*160)
            jsl      printZString
            mend
            macro

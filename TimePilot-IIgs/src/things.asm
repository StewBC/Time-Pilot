;-----------------------------------------------------------------------------
; things.asm
; Part of Time Pilot, the 1982 arcade game remake for the Apple IIgs
;
; Stefan Wessels, 2024
; This is free and unencumbered software released into the public domain.
;-----------------------------------------------------------------------------

                        copy   src/globals.s

THINGS                  START

                        using  GAMEDATA
                        using  TEXT
                        using  VARIABLES

;-----------------------------------------------------------------------------
; MARK: thingsAdd
thingsAdd               entry
                        ldx    zInsertThings             ; look for a zero in the circular buffer
taFind                  lda    activeFlags,x
                        beq    taFound
                        dex
                        dex
                        bpl    taFind
                        ldx    #MAX_OBJECTS-2
                        bra    taFind
taFound                 stx    zInsertThings             ; save where a spot was found for next time
                        tya
                        sta    activeLayer,x
                        lda    dt_layer_flags,y
                        sta    activeFlags,x
                        lda    dt_layer_active_width,y   ; copy the layers into the active slots
                        sta    activeWidth,x
                        lda    dt_layer_active_height,y
                        sta    activeHeight,x
                        lda    zSpawnX
                        sta    activeMinX,x
                        clc
                        adc    dt_layer_active_width,y
                        sta    activeMaxX,x
                        lda    zSpawnY
                        sta    activeMinY,x
                        clc
                        adc    dt_layer_active_height,y
                        sta    activeMaxY,x
                        lda    dt_layer_collide_sig,y
                        sta    activeColsig,x
                        lda    dt_layer_collides_with,y
                        sta    activeCollides,x
                        stz    activeFrame,x
                        stz    activeExtra,x
                        stz    activeScreenAddress,x
                        txa
                        ldx    zNumSortedThingIDs        ; add to the list of sortheThingIDs
                        sta    sortedThingIDs,x
                        inc    zNumSortedThingIDs
                        inc    zNumSortedThingIDs
                        tax                              ; Put new thing into X
                        rts

;-----------------------------------------------------------------------------
; MARK: thingsSortAndCollide
thingsSortAndCollide    entry
tKey                    equ    zTemp00
tMainIndex              equ    zTemp01
tJ                      equ    zTemp03                   ; zTemp02 is used in BCD during collisions
tKeyMinY                equ    zTemp04
tDeadCount              equ    zTemp05
;                        lda    #0                        ; SQW
;                        sta    BORDER
                        stz    tDeadCount                ; Things in list to be removed
                        lda    sortedThingIDs            ; look at 1st thing [0]
                        bpl    tsac0Alive                ; is it alive
                        inc    tDeadCount                ; no - inc dead count
tsac0Alive              ldx    #0                        ; start index at 0
tsacMainSortLoop        inx                              ; go to next
                        inx                              ; Thing 0 is player - never removed
                        cpx    zNumSortedThingIDs        ; processed all?
                        bcs    tsacYSortDone
                        lda    sortedThingIDs,x          ; get the index
                        bpl    tsacXAlive                ; alive?
                        inc    tDeadCount                ; no - inc dead count
                        bra    tsacMainSortLoop          ; go to next thing
tsacXAlive              sta    tKey                      ; this index is the key
                        tay
                        lda    activeMinY,y              ; get the minY for the key
                        sta    tKeyMinY
                        stx    tMainIndex                ; save the current loop index
tsacILoop               dex                              ; iterate backwards
                        dex
                        bmi    tsacILoopDone             ; if < 0 then done
                        lda    sortedThingIDs,x          ; get the index of the previous thing
                        bmi    tsacInclude               ; if it's a dead thing, swap
                        tay                              ; put thing id in Y
                        lda    activeMinY,Y              ; load the Y for the prev thing
                        cmp    tKeyMinY                  ; compare to minY of key
                        bmi    tsacILoopDone             ; if it's smaller no swap
                        beq    tsacILoopDone             ; if it's equal no swap
                        tya                              ; restore thing id from Y
tsacInclude             txy                              ; move the lower "up" by 1
                        iny
                        iny
                        sta    sortedThingIDs,y          ; save the lower index
                        bra    tsacILoop                 ; and keep looking
tsacILoopDone           inx                              ; space was created to insert
                        inx
                        lda    tKey                      ; get the key
                        sta    sortedThingIDs,x          ; insert it
                        ldx    tMainIndex                ; restore the loop counter
                        bra    tsacMainSortLoop          ; iterate whole list
tsacYSortDone           lda    zNumSortedThingIDs
                        asl    tDeadCount
                        beq    tsacNumAliveUpdated
                        sec
                        sbc    tDeadCount                ; carry was set to get here
                        sta    zNumSortedThingIDs
tsacNumAliveUpdated     sta    zNumEraseThingIDs

; sortedThingIDs are now sorted by Y
;                        lda    #1                        ; SQW
;                        sta    BORDER
; do collisions while list sorted in Y
                        ldx    #0                        ; I = 0 & (also in tMainIndex)
tsacMainColLoop         cpx    zNumSortedThingIDs
                        bcc    tsacMainColLoopOk         ; while I < zNumSortedThingIDs
                        jmp    tsacSortOverlap
tsacMainColLoopOk       lda    sortedThingIDs,x          ; key = sortedThingIDs[I]
                        sta    eraseThingIDs,x           ; update erase to Y sorted order
                        tay
                        lda    activeCollides,y
                        bne    tsacDoesCollisions        ; key does collisions
tsacNextI               inx                              ; No, next I
                        inx
                        bra    tsacMainColLoop
tsacDoesCollisions      lda    activeFlags,y
                        bit    #AF_ISDEAD                ; key is alive?
                        bne    tsacNextI                 ; don't check a dead thing
                        stx    tMainIndex                ; alive, so save I
                        sty    tKey                      ; save key (thing under consideration)
tsacNextJ               inx                              ; J = I + 1 (also in tOther)
                        inx
                        cpx    zNumSortedThingIDs
                        bcc    tsacCheckNextThing        ; while J < zNumSortedThingIDs
                        ldx    tMainIndex                ; restore I, next I
                        bra    tsacNextI
tsacCheckNextThing      lda    sortedThingIDs,x          ; other is sortedThingIDs[J]
                        tay                              ; other in Y register
                        lda    activeFlags,y
                        bit    #AF_ISDEAD                ; is other alive
                        bne    tsacNextJ                 ; skip dead things
                        stx    tJ                        ; save J
                        ldx    tKey                      ; key thing now in X register
                        lda    activeMaxY,x              ; get key maxY
                        cmp    activeMinY,y              ; if key maxY >= other MinY then can collide
                        bpl    tsacCouldCollide
                        ldx    tMainIndex                ; noting in rest of list can collide with key
                        bra    tsacNextI                 ; sp restore I, next I
tsacCouldCollide        lda    activeColsig,y
                        and    activeCollides,x          ; do key and other want to test collisions
                        bne    tsacCollideTypes          ; yes
                        ldx    tJ                        ; no - go to next J
                        bra    tsacNextJ
tsacCollideTypes        anop
                        cpx    #0                        ; PLAYER is at index 0 so is X the player
                        beq    tsacXIsPlayer
                        cpy    #0                        ; is Y the player
                        beq    tsacPlayerToX
                        jmp    tsacNonPlayer             ; non-player things might collide
tsacPlayerToX           txy                              ; make Y other
                        ldx    #0                        ; and make X the player
tsacXIsPlayer           anop
                        lda    activeLayer,y
                        cmp    #LAYER_ENEMY
                        bne    tsacPlayerNonEnemy
; Now player in key VS enemy in other
                        lda    activeMinX,y              ; check player (in X) against Enemy (in Y)
                        clc
                        adc    #2
                        cmp    #PLAYER_X+11
                        bmi    tsacOPMxXok               ; player max x in collision range
                        ldx    tJ                        ; restore J
                        bra    tsacNextJ                 ; next J
tsacOPMxXok             lda    activeMaxX,y
                        sec
                        sbc    #6
                        cmp    #PLAYER_X+6
                        bpl    tsacOPMiXok               ; player min x in collision range
                        ldx    tJ
                        bra    tsacNextJ
tsacOPMiXok             lda    activeMinY,y
                        clc
                        adc    #2
                        cmp    #PLAYER_Y+11
                        bmi    tsacOPMxYok               ; player max y in collision range
                        ldx    tJ
                        bra    tsacNextJ
tsacOPMxYok             lda    activeMaxY,y
                        sec
                        sbc    #2
                        cmp    #PLAYER_Y+6
                        bpl    tsacCollides              ; player min y in collision range so a collision
                        ldx    tJ
                        jmp    tsacNextJ                 ; player is not in a collision
tsacPlayerNonEnemy      anop
                        lda    activeMinX,y              ; check non-enemy thing (in Y) against
                        cmp    #PLAYER_X+11              ; the player (in X)
                        bmi    tsacPMxXok                ; player max x in collision range
                        ldx    tJ                        ; restore J
                        jmp    tsacNextJ                 ; next J
tsacPMxXok              lda    activeMaxX,y
                        cmp    #PLAYER_X+6
                        bpl    tsacPMiXok                ; player min x in collision range
                        ldx    tJ
                        jmp    tsacNextJ
tsacPMiXok              lda    activeMinY,y
                        cmp    #PLAYER_Y+11
                        bmi    tsacPMxYok                ; player min y in collision range
                        ldx    tJ
                        jmp    tsacNextJ
tsacPMxYok              lda    activeMaxY,y
                        cmp    #PLAYER_Y+6
                        bpl    tsacCollides              ; player min y in collision range so a collision
                        ldx    tJ
                        jmp    tsacNextJ                 ; player is not in a collision
tsacNonPlayer           anop
                        lda    activeMinX,y              ; check non-enemy thing (in Y) against
                        cmp    activeMaxX,x              ; the player (in X)
                        bmi    tsacNPxXok                ; player max x in collision range
                        ldx    tJ                        ; restore J
                        jmp    tsacNextJ                 ; next J
tsacNPxXok              lda    activeMaxX,y
                        cmp    activeMinX,x
                        bpl    tsacNPiXok                ; player min x in collision range
                        ldx    tJ
                        jmp    tsacNextJ
tsacNPiXok              lda    activeMinY,y
                        cmp    activeMaxY,x
                        bmi    tsacNPxYok                ; player min y in collision range
                        ldx    tJ
                        jmp    tsacNextJ
tsacNPxYok              lda    activeMaxY,y
                        cmp    activeMinY,x
                        bpl    tsacCollides              ; player min y in collision range so a collision
                        ldx    tJ
                        jmp    tsacNextJ                 ; player is not in a collision
tsacCollides            stx    zThingID1                 ; There is a collision
                        sty    zThingID0                 ; save key and other
                        jsr    collideThings             ; collide them (0 first)
                        ldy    zThingID1                 ; reverse order
                        ldx    zThingID0
                        stx    zThingID1
                        sty    zThingID0
                        jsr    collideThings             ; and collide them again (now 0)
                        ldx    tMainIndex                ; restore I
                        jmp    tsacNextI                 ; next I
tsacNotPlayerCollision  lda    activeMaxX,x              ; neither key nor other a player
                        cmp    activeMinX,y
                        bpl    tsacMxXok                 ; max x key >= min x other
                        ldx    tJ
                        jmp    tsacNextJ
tsacMxXok               lda    activeMaxX,y
                        cmp    activeMinX,x
                        bpl    tsacCollides              ; maxX other >= minX key, so collide
                        ldx    tJ
                        jmp    tsacNextJ                 ; things don't collide, next J
; Collisions handled.  Now sort overlapping (in Y) sprites by layer
; for painters draw.  There are 2 parts - the draw by higher layers come later
; and the erase where higher layers come sooner
; In the code, x reg is I, then J, then Start, then K
;tKey                      equ zTemp00
tI                      equ    zTemp01
tK                      equ    zTemp02                   ; No BCD post this point so zTemp02 used
tMaxY                   equ    zTemp04                   ; tJ is 3
tValue                  equ    zTemp05
tsacSortOverlap         ldx    #0                        ; i = 0
;                        lda    #2                        ; SQW
;                        sta    BORDER
tsacOverlapThingLoopOk  lda    sortedThingIDs,x          ; get the thing (key)
                        tay
                        lda    activeMaxY,y              ; get the max height of the thing
                        sta    tMaxY                     ; save the max height
                        stx    tI                        ; save I
tsacOverlapLoop         inx                              ; j = i + 1
                        inx
                        cpx    zNumSortedThingIDs        ; j < zNumSortedThingIDs
                        bcs    tsacProcessOverlap        ; no, end of list
                        lda    sortedThingIDs,x          ; get thing[J]
                        tay
                        lda    activeMinY,y              ; get the minY
                        cmp    tMaxY
                        bpl    tsacProcessOverlap        ; minY[j] >= tMaxY, ends overlap
                        lda    activeMaxY,y              ; get maxY[j]
                        cmp    tMaxY                     ; see if J extends the overlap down
                        bmi    tsacOverlapLoop           ; no, try next thing
                        sta    tMaxY                     ; yes, update maxY
                        bra    tsacOverlapLoop           ; try next thing
; an overlap identified - sort sortedThings by layer with higher later "higher"
tsacProcessOverlap      stx    tJ                        ; save J
                        ldx    tI                        ; k = i
tsacInsertLoop          inx                              ; k++
                        inx
                        cpx    tJ                        ; k < j
                        bcs    tsacOvlSorted             ; no, done sorting overlap
                        lda    sortedThingIDs,x          ; get thing[k]
                        sta    tKey                      ; save as key
                        tay
                        lda    activeLayer,y             ; get the layer
                        sta    tValue                    ; save as value
                        stx    tK                        ; save k
tsacInsertSearch        dex                              ; l = k - 1
                        dex
                        cpx    tI
                        bmi    tsacInsertFound           ; k < I - insert now (at bottom)
                        lda    sortedThingIDs,x          ; thing[k]
                        tay                              ; y reg now index to thing[k]
                        lda    tValue
                        cmp    activeLayer,y
                        bpl    tsacInsertFound           ; value >= layer[thing[k]] then insert
                        tya                              ; thing[k] index in a
                        txy                              ; k in y reg
                        iny                              ; k+1
                        iny
                        sta    sortedThingIDs,y          ; thing[k+1] = thing[j]
                        sta    eraseThingIDs,y           ; keep sorted with sortedThingIDs
                        bra    tsacInsertSearch          ; keep looking for where to insert
tsacInsertFound         inx                              ; k + 1
                        inx
                        lda    tKey
                        sta    sortedThingIDs,x          ; thing[k+1] = key - inserted
                        sta    eraseThingIDs,x           ; keep sorted with sortedThingIDs
                        ldx    tK
                        bra    tsacInsertLoop
; Now put the thing with the biggest maxY at the top so it's the
; first that needs to be erased - guaranteeing that everything this overlaps with comes later
; and that the new draw order will paint right.  Without this if layer 0 is followed by
; layer 1, overlapping, l0 will erase and draw and then l1 will erase taking l0 with it
; this prevents all that and is faster (but less accurate) than sorting the erase by layer
; (inverted from draw order) for the overlapping region
tsacOvlSorted           ldx    tJ
                        dex
                        dex
                        cpx    tI
                        beq    tsacEraseSorted           ; if j = i + 1 then do nothing
                        ldx    tI
                        ldy    tJ
                        dey
                        dey
                        lda    eraseThingIDs,x           ; swap the 1st and last entries
                        pha                              ; in the overlapped region
                        lda    eraseThingIDs,y           ; for erasething.  That makes the
                        sta    eraseThingIDs,x           ; highest layer draw thing
                        pla                              ; block all draws till it was erased
                        sta    eraseThingIDs,y           ; then everything under it can erase
tsacEraseSorted         ldx    tJ                        ; and draw
                        cpx    zNumSortedThingIDs        ; i < zNumSortedThingIDs
                        bcs    tsacDone
                        jmp    tsacOverlapThingLoopOk
;                        lda    #3                        ; SQW
;                        sta    BORDER
tsacDone                rts

thisisaformattinglabel  anop
                        END

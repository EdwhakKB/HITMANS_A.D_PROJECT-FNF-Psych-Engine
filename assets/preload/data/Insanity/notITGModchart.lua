--Modchart By EDWHAK
function onCreatePost()
    ---------------MODIFIERS-----------------
    ---------DO NOT FUCKING TOUCH!-----------

    --PLAYER

    --OPPONENT

    startMod('strumStealthOP','StealthModifier','OPPONENT',-1)

    --LANE

    --BOTH

    --CUSTOM

    ---------------PLAYFIELDS---------------
    
    --PLAYER

    --DEFAULT PLAYFIELD

    startMod('JumpPL','JumpModifier','PLAYER',0)
    startMod('strumStealthPL','StealthModifier','PLAYER',0)
    startMod('notesStealthPL','NoteStealthModifier','PLAYER',0)

    --PLAYFIELD 1

    addPlayfield(0,0,0)
    startMod('strumStealthPFBASE','StealthModifier','PLAYER',1)
    startMod('JumpPF','JumpModifier','PLAYER',1)
    startMod('strumStealthPF','StealthModifier','PLAYER',1)
    startMod('notesStealthPF','NoteStealthModifier','PLAYER',1)

    --OPPONENT

    --BOTH

    ------------END OF MODIFIERS------------
    ----------------MODCHART----------------
   
    set(0, [[
        1, strumStealthPFBASE,
        1, strumStealthOP
    ]])

    set(128, [[
        0, strumStealthPFBASE,
        0, strumStealthPF,
        1, notesStealthPF,
        0, strumStealthPL
    ]])
    ease(129, 1, 'easeOut',[[
        1, JumpPL,
    ]])
    -----------END OF THE MODCHART-----------
end
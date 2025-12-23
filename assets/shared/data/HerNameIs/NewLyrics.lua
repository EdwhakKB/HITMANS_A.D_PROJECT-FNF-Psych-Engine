--HerNameIs lyrics 2.0!
lyrics = {
    "It's a bit difficult for me to hesitate to meet someone.",
    "Do you want to know me then",
    "Stop spinning around and say it clearly.",    
    "I made special time",
    "This busy city won't wait for you",
    "Don't you know yet? baby, baby",
    "Even if you pass me by",
    "I don't care. Boy, I don't cry",
    "Yes, I’m anxious because you can’t meet me",
    "There are a lot of guys, so",
    "Hurry up, I'm a busy lady.",
    "Time is just passing by",
    "What is this? If it’s like this, let’s go",
    "If you reconsider and reconsider, I'll step back.",
    "You may end up regretting it forever",
    "My cold expression is getting colder.",
    "It's really frustrating. Baby, baby",
    "Even if you pass me by",
    "I don't care. Boy, I don't cry",
    "Yes, I’m anxious because you can’t meet me",
    "There are a lot of guys, so",
    "Hurry up, I'm a busy lady.",
    "Even if you pass me by",
    "I don't care. Boy, I don't cry",
    "Yes, I’m anxious because you can’t meet me",
    "There are a lot of guys, so",
    "Even if you pass me by",
    "I don't care. Boy, I don't cry",
    "Yes, I’m anxious because you can’t meet me",
    "There are a lot of guys, so",
    "Hurry up, I'm... a busy lady."
}

function onCreatePost()
    makeLuaText('HerVoice', '', 890, 0, 510)
	screenCenter('HerVoice', 'x')
	setTextBorder('HerVoice', 2, '000000')
	setTextSize('HerVoice', 50)
    setTextFont('HerVoice', 'BIRTLOVE.otf')
    setTextColor('HerVoice', 'fa89de')
    setObjectCamera('HerVoice', 'camHUD')
    addLuaText('HerVoice', true)
	setTextAlignment('HerVoice', 'center')
end

local wordstuff = {
	{
        --0:35 - 0:38
		startTime = 35, -- Hace fix pa esto po
		fadeTime = 38.45,
        started = false,
        fade = false
	},
	{
        --0:38-0:42
		startTime = 38.59, -- No se como es que el lua lee el time XD
		fadeTime = 43.08,
        started = false,
        fade = false
	},
    {
        --0:43-0:47
		startTime = 43.79, -- No se como es que el lua lee el time XD
		fadeTime = 47.19, 
        started = false,
        fade = false
	},
    {
        --0:47-0:51
		startTime = 47.33, -- No se como es que el lua lee el time XD
		fadeTime = 51.95, 
        started = false,
        fade = false
	},
    {
        --0:51-0:59
		startTime = 52.5, -- No se como es que el lua lee el time XD
		fadeTime = 60.13, 
        started = false,
        fade = false
	},
    {
        --0:59-1:04
		startTime = 60.55, -- No se como es que el lua lee el time XD
		fadeTime = 64.54, 
        started = false,
        fade = false
	},
    {
        --1:06-1:08
		startTime = 65.6, -- No se como es que el lua lee el time XD
		fadeTime = 68.63, 
        started = false,
        fade = false
	},
    {
        --1:08-1:13
		startTime = 69.13, -- No se como es que el lua lee el time XD
		fadeTime = 73.79, 
        started = false,
        fade = false
	},
    {
        --1:14-1:17
		startTime = 74.31, -- No se como es que el lua lee el time XD
		fadeTime = 77.36, 
        started = false,
        fade = false
	},
    {
        --1:17-1:22
		startTime = 77.86, -- No se como es que el lua lee el time XD
		fadeTime = 82.5, 
        started = false,
        fade = false
	},
    {
        --1:22-1:27
		startTime = 82.77, -- No se como es que el lua lee el time XD
		fadeTime = 87.27, 
        started = false,
        fade = false
	},
    {
        --1:44-1:47
        startTime = 104.87, -- No se como es que el lua lee el time XD
		fadeTime = 107.98, 
        started = false,
        fade = false
    },
    {   
        --1:48-1:53
        startTime = 108.34, -- No se como es que el lua lee el time XD
		fadeTime = 112.34, 
        started = false,
        fade = false
    },
    {
       --1:53-1:56
        startTime = 113.53, -- No se como es que el lua lee el time XD
		fadeTime = 117.2, 
        started = false,
        fade = false
    },
    {  
        --1:56-2:01
        startTime = 117.35, -- No se como es que el lua lee el time XD
		fadeTime = 121.98, 
        started = false,
        fade = false
    },
    {
        --2:02-2:09
        startTime = 122.25, -- No se como es que el lua lee el time XD
		fadeTime = 130.30, 
        started = false,
        fade = false
    },
    {    
        --2:10-2:14
        startTime = 130.5, -- No se como es que el lua lee el time XD
		fadeTime = 134.29, 
        started = false,
        fade = false
    },    
    {    --2:15-2:17
        startTime = 135.36, -- No se como es que el lua lee el time XD
		fadeTime = 138.45, 
        started = false,
        fade = false
    },
    {      
        --2:17-2:23
        startTime = 138.86, -- No se como es que el lua lee el time XD
		fadeTime = 143.4, 
        started = false,
        fade = false
    },
    {    
        --2:23-2:26
        startTime = 144.18, -- No se como es que el lua lee el time XD
		fadeTime = 147.22, 
        started = false,
        fade = false
    },    
    {
        --2:26-2:32
        startTime = 147.65, -- No se como es que el lua lee el time XD
		fadeTime = 152.17, 
        started = false,
        fade = false
    },
    {
        --2:32-2:36
        startTime = 152.48, -- No se como es que el lua lee el time XD
		fadeTime = 157.16, 
        started = false,
        fade = false
    },
    {    
        --2:36-2:39
        startTime = 157.27, -- No se como es que el lua lee el time XD
		fadeTime = 160.36, 
        started = false,
        fade = false
    },
    {    
        --2:39-2:45
        startTime = 160.68, -- No se como es que el lua lee el time XD
		fadeTime = 165.23, 
        started = false,
        fade = false
    },
    {
        --2:45-2:48
        startTime = 165.95, -- No se como es que el lua lee el time XD
		fadeTime = 169.09, 
        started = false,
        fade = false
    },
    {
        --2:48-2:53
        startTime = 169.45, -- No se como es que el lua lee el time XD
		fadeTime = 174.04, 
        started = false,
        fade = false
    },
    {    
        --2:54-2:57
        startTime = 174.68, -- No se como es que el lua lee el time XD
		fadeTime = 177.86, 
        started = false,
        fade = false
    },
    {    
        --2:57-3:02
        startTime = 178.14, -- No se como es que el lua lee el time XD
		fadeTime = 182.95, 
        started = false,
        fade = false
    },
    {
        --3:03-3:05
        startTime = 183.14, -- No se como es que el lua lee el time XD
		fadeTime = 186.59, 
        started = false,
        fade = false
    },
    {
        --3:06-3:10
        startTime = 186.91, -- No se como es que el lua lee el time XD
		fadeTime = 191.40, 
        started = false,
        fade = false
    },
    {
        --3:11-3:18
        startTime = 191.77, -- No se como es que el lua lee el time XD
		fadeTime = 198.69, 
        started = false,
        fade = false
    }
}

--[[
Simple Min to Secs math

Secs = CurrMin/60Secs 60 / 1 * 4
Min = 60Secs/CurrMin 60*1 

Have fun!
]]

function onUpdatePost()
	local sPos = getSongPosition()
	
	for i = 1, #lyrics do
		if sPos/1000 > wordstuff[i].startTime and not wordstuff[i].started then
            wordstuff[i].started = true
			textThing('HerVoice', true)
		    setTextString('HerVoice', lyrics[i])
		end
		
		if sPos/1000 > wordstuff[i].fadeTime and not wordstuff[i].fade then
            wordstuff[i].fade = true
            textThing('HerVoice', false)
		end
	end
end

function textThing(tag, incoming)
    if incoming then
	    setProperty(tag..'.y', 510)
	    doTweenY(tag..'Popup', tag, getProperty(tag..'.y')+10, 0.3, 'linear')
        doTweenAlpha(tag..'funny', tag, 1, 0.1, 'linear')
    else
	    doTweenY(tag..'Popup', tag, getProperty(tag..'.y')+10, 0.3, 'linear')
        doTweenAlpha(tag..'funny', tag, 0, 0.1, 'linear')
    end
end

// class TweenModule
// {
//     public function tweenModuleLerp(a:Float, b:Float, t:Float)
//     {
//         return a * (1-t) + b * t;
//     }

//     public function remapToOne(min:Float, max:Float, t:Float)
//     {
//         return (t - min) / (max - min);
//     }

//     public function _comb(n:Int, k:Int):Float
//     {
//         var res = 1;
//         for (i in 0...k)
//         {
//             res = res * (n - i) / i;
//         }
//         return res;
//     }

//     public function _bezierPath(t:Float, points:Arra<Float>):Float
//     {
//         var n:Int = points.length - 1;
//         var curve:Float = 0;

//         for (i in 0...points.length) {
//             var coeff:Float = 1;
//             for (j in 0...i) {
//                 coeff = coeff * (n - j) / (j + 1);
//             }

//             curve += coeff * Math.pow(1 - t, n - i) * Math.pow(t, i) * points[i];
//         }

//         return curve;
//     }

//     public function ValueToKey(t)
//     {
//         var i = {};
//         for (k => v in t)
//         {
//             i[k] = k;
//         }
//         return i;
//     }

//     public function inKeyInTbl(tbl)
//     {
//         for (i => v in tbl)
//         {
//             if (Std.isOfType(i, String))
//             {
//                 return true;
//             }
//         }
//         return false;
//     }

//     public function reverseTable(table:DynamicAccess<Dynamic>)
//     {
//         var h:DynamicAccess<Dynamic> = {};
//         for (i in 0...Math.floor(table.length/2))
//         {
//             var j = table.length - i + 1;
//             h[i] = table[j];
//             h[j] = table[i];
//         }
//         return h;
//     }

//     public var TweenSignal:DynamicAccess<{Threads:DynamicAccess<Dynamic>, __index:DynamicAccess<Dynamic>}> = {};

//     public var TweenSignalNew:DynamicAccess<{->Void}
// }

// local Signal = {}
// Signal.Threads = {}
// Signal.__index = Signal
// function Signal.New(call)
//     local self = {}
//     self.Active = true
//     self.Paused = false
//     self.Elapsed = 0
//     self.CallFunc = call
//     function self:Pause()
//         self.Paused = true
//     end
//     function self:Resume()
//         self.Paused = false
//     end
//     function self:Disconnect()
//         self.Active = false
//     end
//     table.insert(Signal.Threads,setmetatable(self,Signal))
//     return setmetatable(self,Signal)
// end

// local Tween = {}
// Tween.CurrentTweens = {}
// Tween.CurrentPlaying = {}
// Tween.__index = Tween

// function Tween.Update(elapsed) -- cant use onUpdate cuz when using a script and require with it the onUpdate in module stops so put this shit in onUpdate or onUpdatePost with the elapsed parameter yeah idk
//     for i,v in next,Signal.Threads do
//         if v.Active and not v.Paused then
//             v.CallFunc(elapsed)
//         elseif not v.Paused then
//             Signal.Threads[i] = nil
//         end
//     end
// end

// local _Ease = require([[mods\module\Eases]])
// local Ease = {}
// for i,v in next,_Ease do
//     Ease[i:lower()] = v;
// end
// local valueLists = {['x'] = '.x' ,['y'] = '.y',['offsetx'] = 'offset.x',['offsety'] = 'offset.y' ,['scalex'] = '.scale.x' ,['scaley'] = '.scale.y' ,['width'] = '.width' ,['height'] = '.height' ,['angle'] = '.angle' ,['alpha'] = '.alpha',['noteoffsetx'] = 'offsetX',['noteoffsety'] = 'offsetY'}

// function Tween.Create(obj,position,duration,options)
//     local lowercase = {{},{}}
//     local self = {}
//     if type(position) ~= 'table' then
//         debugPrint('ERROR : Position must be a table.')
//         return nil
//     elseif isKeyinTbl(position) then
//         for i,v in pairs(position) do
//             lowercase[1][i:lower()] = v
//         end
//     end
//     if type(options) ~= 'table' then
//         debugPrint('WARNING : Options is not a table! Making it a default rn..')
//         self.options = {easedirection = 'linear'}
//     else
//         for i,v in pairs(options) do
//             lowercase[2][i:lower()] = v
//         end
//         self.options = lowercase[2]
//     end
//     self.obj = obj
//     if not isKeyinTbl(position) then self.position = position[1] 
//     else self.position = {} end
//     self.pos = isKeyinTbl(position) and lowercase[1] or position
//     -- POSITIONS: x , y , scalex , scaley , width , height , angle , alpha
//     self.duration = duration
//     -- OTHERS: EaseDirection, Delay, OnComplete, OnInterrupt, UseSongPos, startTimePos, UseBeatHit, startBeatHit, Reverse, 
//     --          UseVarTweenInstead (FOR KEY TABLE POSITIONS)
//     self.IsPlaying = false
//     self.Ended = false
//     table.insert(Tween.CurrentTweens,setmetatable(self,Tween))
//     return setmetatable(self,Tween)
// end

// function Tween:Play()
//     local obj = self.obj
//     local songpos = getSongPosition()
//     --[[
//     for i,v in next,Tween.CurrentPlaying do
//         if i:find(obj) then
//             Tween.CurrentPlaying[i] = false
//             break
//         end
//     end]]
//     if Tween.CurrentPlaying[obj] then
//         Tween.CurrentPlaying[obj]()
//     end 

//     --local random = obj..'_'..getRandomInt(10000000,99999999)

//     local currentOptions = self.options
//     local iscustomease = false
//     local easedir = Ease[currentOptions.easedirection:lower()] and currentOptions.easedirection:lower() or type(currentOptions.easedirection) == 'table' and currentOptions.easedirection or 'linear'
//     if type(currentOptions.easedirection) == 'table' then
//         iscustomease = true
//     end

//     local currentSongTime = currentOptions.starttimepos and currentOptions.starttimepos * crochet or songpos
//     local currentDelayTime = currentOptions.starttimepos and currentOptions.starttimepos * crochet or songpos
//     if currentOptions.usebeathit then currentOptions.starttimepos = false; currentDelayTime = currentOptions.usebeathit and currentOptions.startbeathit or curDecBeat end -- ignore when usebeathit is true
//     local currentBeatHit = currentOptions.usebeathit and currentOptions.startbeathit or curDecBeat

//     local currentDuration = self.duration
//     local currentType = self.type
//     local timer = 0
//     local currentValues = self.pos
//     local delay = {0,currentOptions.delay or 0}
//     local lesignal
//     local disconnect = false

//     Tween.CurrentPlaying[obj] = function() -- recently found a new method instead of looping object name with random fuchin numbers
//         disconnect = true
//         Tween.CurrentPlaying[obj] = nil
//     end
//     if isKeyinTbl(self.pos) then
//         local newvalue = {}
//         for i,v in next,currentValues do
//             newvalue[i] = {}
//             --newvalue[i][1] = getProperty(obj..valueLists[i])
//             newvalue[i][1] = currentOptions.usevartweeninstead and 0 or getProperty(obj.."."..i)
//             if newvalue[i][1] ~= nil then
//                 if type(v) == 'table' or currentOptions.usevartweeninstead then
//                     for a,curv in next,v do
//                         newvalue[i][a + (currentOptions.usevartweeninstead and 0 or 1)] = curv
//                     end
//                     if currentOptions.reverse then newvalue[i] = reverseTable(newvalue[i]) end
//                 else
//                     if currentOptions.reverse then  
//                         newvalue[i][2] = newvalue[i][1]
//                         newvalue[i][1] = v
//                     else
//                         newvalue[i][2] = v
//                     end
//                 end
//             end
//             self.position[i] = newvalue[i][1]
//         end
//         --local magnitude = {math.sqrt((self.pos.x or 0)^2 + (self.pos.y or 0)^2),math.sqrt(startValues.x^2 + startValues.y^2)}
//         lesignal = Signal.New(function(dt)
//             local songpos = getSongPosition()
//             if delay[1] < delay[2] then
//                 if currentOptions.usesongpos then
//                     delay[1] = (songpos - currentDelayTime) / 1000
//                     currentSongTime = songpos
//                 elseif currentOptions.usebeathit then
//                     delay[1] = (curDecBeat - currentDelayTime)
//                     currentBeatHit = curDecBeat
//                 else
//                     delay[1] = delay[1] + dt
//                 end
//                 return
//             else
//                 self.IsPlaying = true
//                 self.Ended = false
//             end
//             --if Tween.CurrentPlaying[random] == false then
//             if disconnect then
//                 self.IsPlaying = false
//                 self.Ended = true
//                 if currentOptions.oninterrupt  ~= nil then currentOptions.oninterrupt(true) end
//                 lesignal:Disconnect()
//             end
//             local ratio = iscustomease and _bezierPath(remapToOne(0,currentDuration,timer),currentOptions.easedirection) 
//                                         or Ease[easedir](timer,0,1,currentDuration,currentOptions.amplitude or currentOptions.overshoot,currentOptions.elasticityperiod)
//             local destinated = {}
//             for i,v in pairs(newvalue) do
//                 local succ,err = pcall(function()
//                     local result = _bezierPath(ratio,newvalue[i])
//                     if not currentOptions.usevartweeninstead then setProperty(obj.."."..i,result) end
//                     self.position[i] = result
//                 end)
//                 if not succ then debugPrint('ERROR: Something wrong with the values you have input! Tween has been ended.'); Tween.CurrentPlaying[obj](); return end
//             end
//             --[[
//             for i,v in pairs(destinated) do
//                 if i == ValueToKey(valueLists)[i] then
//                     setProperty(obj..valueLists[i],v)
//                 end
//                 setProperty(obj.."."..i,v)
//             end]]

//             timer = currentOptions.usesongpos and (songpos - currentSongTime) / 1000 or (currentOptions.usebeathit and curDecBeat - currentBeatHit) or timer + dt
//             if timer >= currentDuration then
//                 timer = currentDuration
//                 for i,v in next,currentValues do
//                     --[[if type(v) ~= 'table' then
//                         setProperty(obj..valueLists[i],v)
//                     else
//                         setProperty(obj..valueLists[i],v[3])
//                     end ]]
//                     if not currentOptions.usevartweeninstead then
//                         if type(v) ~= 'table' then
//                             setProperty(obj.."."..i,v)
//                         else
//                             setProperty(obj.."."..i,v[#v])
//                         end
//                     else
//                         if type(v) ~= 'table' then
//                             self.position[i] = v
//                         else
//                             self.position[i] = v[#v]
//                         end
//                     end
//                 end
//                 if currentOptions.oncomplete ~= nil then currentOptions.oncomplete() end
//                 Tween.CurrentPlaying[obj] = nil
//                 self.IsPlaying = false
//                 self.Ended = true
//                 lesignal:Disconnect()
//             end
//         end)
//     else
//         local idkValues = currentOptions.reverse and reverseTable(currentValues) or currentValues
//         lesignal = Signal.New(function(dt)
//             local songpos = getSongPosition()
//             if delay[1] < delay[2] then
//                 if currentOptions.usesongpos then
//                     delay[1] = (songpos - currentDelayTime) / 1000
//                     currentSongTime = songpos
//                 elseif currentOptions.usebeathit then
//                     delay[1] = (curDecBeat - currentDelayTime)
//                     currentBeatHit = curDecBeat
//                 else
//                     delay[1] = delay[1] + dt
//                 end
//                 return
//             else
//                 self.IsPlaying = true
//                 self.Ended = false
//             end
//             --if Tween.CurrentPlaying[random] == false then
//             if disconnect then
//                 self.IsPlaying = false
//                 self.Ended = true
//                 if currentOptions.oninterrupt  ~= nil then currentOptions.oninterrupt(true) end
//                 lesignal:Disconnect()
//             end
//             timer = currentOptions.usesongpos and (songpos - currentSongTime) / 1000 or (currentOptions.usebeathit and curDecBeat - currentBeatHit) or timer + dt
//             local ratio = iscustomease and _bezierPath(remapToOne(0,currentDuration,timer),currentOptions.easedirection) 
//                                         or Ease[easedir](timer,0,1,currentDuration,currentOptions.amplitude or currentOptions.overshoot,currentOptions.elasticityperiod)
//             local succ,err = pcall(function()
//                 self.position = _bezierPath(ratio,idkValues)
//             end)
//             if not succ then debugPrint('ERROR: Something wrong with the values you have input! Tween has been ended. OBJ: '..obj); Tween.CurrentPlaying[obj](); return end
//             --[[
//             if #currentValues >= 2 and #currentValues <= 3 then
//                 if type(currentValues[1]) ~= 'number' then
//                     lesignal:Disconnect()
//                     return
//                 end
//                 self.position = currentOptions.lerpfix and tweenmodulelerp(ratio,currentValues[1],currentValues[2]) or tweenmodulelerp(currentValues[1],currentValues[2],ratio)
//             elseif #currentValues == 4 then
//                 self.position = cubicBezier(ratio,currentValues[1],currentValues[2],currentValues[3],currentValues[4])
//             end]]

//             if timer >= currentDuration then
//                 timer = currentDuration
//                 if #currentValues >= 2 and #currentValues <= 3 then
//                     self.position = idkValues[2]
//                 elseif #currentValues == 4 then
//                     self.position = idkValues[4]
//                 end
//                 if currentOptions.oncomplete ~= nil then currentOptions.oncomplete() end
//                 Tween.CurrentPlaying[obj] = nil
//                 self.IsPlaying = false
//                 self.Ended = true
//                 lesignal:Disconnect()
//             end
//         end)
//     end
//     return self
// end

// function Tween:Stop()
//     --[[
//     for i,v in next,Tween.CurrentPlaying do
//         if i:find(self.obj) then
//             Tween.CurrentPlaying[i] = false
//             break
//         end
//     end]]
//     if Tween.CurrentPlaying[self.obj] then
//         Tween.CurrentPlaying[self.obj]()
//     end
//     return self
// end

// function Tween:Set(position,duration)
//     local lowercase = {}
//     if type(position) ~= 'table' then
//         debugPrint('ERROR : Position must be a table.')
//         return
//     elseif isKeyinTbl(position) then
//         for i,v in pairs(position) do
//             lowercase[i:lower()] = v
//         end
//     end
//     if not isKeyinTbl(position) then self.position = position[1] end
//     self.pos = isKeyinTbl(position) and lowercase or position
//     -- POSITIONS: x , y , scalex , scaley , width , height , angle , alpha
//     self.duration = duration or self.duration
//     return self
// end

// function Tween:SetOptions(options)
//     local lowercase = {}
//     if type(options) ~= 'table' then
//         debugPrint('WARNING : Options is not a table! Making it a default rn..')
//         self.options = {easedirection = 'linear'}
//     else
//         for i,v in pairs(options) do
//             lowercase[i:lower()] = v
//         end
//         self.options = lowercase
//     end
//     return self
// end

// function Tween.GetCurrentPlaying(name)
//     if Tween.CurrentPlaying[name] then
//         return true
//     end
//     return false
// end

// function Tween.GetPositionByName(name)
//     for i,v in pairs(Tween.CurrentTweens) do
//         if v.obj:find(name) then
//             return v.position
//         end
//     end
//     return 0
// end

// return Tween
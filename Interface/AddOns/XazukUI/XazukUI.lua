-- HIDE MAIN BLIZZARD STUFF
-- MainMenuBar:SetScale(.9)
-- MainMenuBar:ClearAllPoints()
-- MainMenuBar:SetPoint("BOTTOM",UIParent,"BOTTOM",0,-60)
-- MainMenuExpBar:Hide()
MainMenuBarLeftEndCap:Hide()
MainMenuBarRightEndCap:Hide()
UIErrorsFrame:Hide()

-- ACTION BARS
-- ActionButton1:ClearAllPoints()
-- ActionButton1:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",430,85)
-- MultiBarBottomLeftButton1:ClearAllPoints()
-- MultiBarBottomLeftButton1:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",430,45)
-- MultiBarBottomRightButton1:ClearAllPoints()
-- MultiBarBottomRightButton1:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",430,5)

-- PetActionBarFrame:ClearAllPoints()
-- PetActionBarFrame:SetPoint("BOTTOM",UIParent,"BOTTOM",50,35)
-- PetActionBarFrame:SetScale(1)

-- CHAT FRAME
-- ChatFrame1:ClearAllPoints()
-- ChatFrame1:SetPoint("BOTTOMLEFT",0,-150)
-- ChatFrame1:SetWidth(390)
-- ChatFrame1EditBox:SetWidth(400)

-- PLAYER FRAMES
PlayerFrame:ClearAllPoints()
PlayerFrame:SetPoint("CENTER",-120,-150)
TotemFrame:ClearAllPoints()
-- TotemFrame:SetPoint("CENTER",115,50)
TotemFrame:SetPoint("BOTTOM",UIParent,"BOTTOM",0,280)
DemonicFuryBarFrame:ClearAllPoints()
DemonicFuryBarFrame:SetPoint("BOTTOM",UIParent,"BOTTOM",0,280)
ShardBarFrame:ClearAllPoints()
ShardBarFrame:SetPoint("BOTTOM",UIParent,"BOTTOM",0,280)

-- PET FRAME
-- PetFrame:ClearAllPoints()
-- PetFrame:SetPoint("TOPLEFT",20,35)

-- TARGET FRAMES
-- TargetFrame:ClearAllPoints()
-- TargetFrame:SetPoint("CENTER",120,-150)
-- TargetFrameSpellBar:ClearAllPoints()
-- TargetFrameSpellBar:SetPoint("CENTER",-17,50)
-- TargetFrameSpellBar.SetPoint = function() end
-- TargetFrameSpellBar:SetScale(1)

-- FOCUS FRAMES
FocusFrame:ClearAllPoints()
FocusFrame:SetPoint("CENTER",-95,132)
FocusFrameSpellBar:ClearAllPoints()
FocusFrameSpellBar:SetPoint("CENTER",UIParent,"CENTER",0,0)
FocusFrameSpellBar.SetPoint = function() end
FocusFrameSpellBar:SetScale(1.0)


-- ARENA FRAMES
LoadAddOn("Blizzard_ArenaUI")

ArenaEnemyFrame1:ClearAllPoints()
ArenaEnemyFrame2:ClearAllPoints()
ArenaEnemyFrame3:ClearAllPoints()
ArenaEnemyFrame4:ClearAllPoints()
ArenaEnemyFrame5:ClearAllPoints()

ArenaEnemyFrame1:SetPoint("CENTER",UIParent,"CENTER",-280,150)
ArenaEnemyFrame2:SetPoint("CENTER",UIParent,"CENTER",-280,100)
ArenaEnemyFrame3:SetPoint("CENTER",UIParent,"CENTER",-280,50)
ArenaEnemyFrame4:SetPoint("CENTER",UIParent,"CENTER",-280,0)
ArenaEnemyFrame5:SetPoint("CENTER",UIParent,"CENTER",-280,-50)

ArenaEnemyFrame1CastingBar:SetScale(1.3)
ArenaEnemyFrame2CastingBar:SetScale(1.3)
ArenaEnemyFrame3CastingBar:SetScale(1.3)
ArenaEnemyFrame4CastingBar:SetScale(1.3)
ArenaEnemyFrame5CastingBar:SetScale(1.3)

ArenaEnemyFrame1.SetPoint = function() end
ArenaEnemyFrame2.SetPoint = function() end
ArenaEnemyFrame3.SetPoint = function() end
ArenaEnemyFrame4.SetPoint = function() end
ArenaEnemyFrame5.SetPoint = function() end

trinkets = {}
local arenaFrame, trinket
for i = 1, 5 do
  arenaFrame = "ArenaEnemyFrame"..i
  trinket = CreateFrame("Cooldown", arenaFrame.."Trinket", ArenaEnemyFrames)
  trinket:SetPoint("TOPRIGHT", arenaFrame, 30, -6)
  trinket:SetSize(24, 24)
  trinket.icon = trinket:CreateTexture(nil, "BACKGROUND")
  trinket.icon:SetAllPoints()
  trinket.icon:SetTexture("Interface\\Icons\\inv_jewelry_trinketpvp_01")
  trinket:Hide()
  trinkets["arena"..i] = trinket
end

local events = CreateFrame("Frame")
function events:UNIT_SPELLCAST_SUCCEEDED(unitID, spell, rank, lineID, spellID)
  if not trinkets[unitID] then
    return
  end
  if spellID == 59752 or spellID == 42292 then
    CooldownFrame_SetTimer(trinkets[unitID], GetTime(), 120, 1)
    SendChatMessage("Trinket used by: "..GetUnitName(unitID, true), "PARTY")
  end
end

function events:PLAYER_ENTERING_WORLD()
  local _, instanceType = IsInInstance()
  if instanceType == "arena" then
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
  elseif self:IsEventRegistered("UNIT_SPELLCAST_SUCCEEDED") then
    self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    for _, trinket in pairs(trinkets) do
      trinket:SetCooldown(0, 0)
      trinket:Hide()
    end
  end
end
events:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)
events:RegisterEvent("PLAYER_ENTERING_WORLD")

-- MOVE BAG FRAME
-- MainMenuBarBackpackButton:ClearAllPoints()
-- MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0,2.5)

-- HIDE BAGS
-- CharacterBag3Slot:Hide()
-- CharacterBag2Slot:Hide()
-- CharacterBag1Slot:Hide()
-- CharacterBag0Slot:Hide()

-- MOVE MICRO MENU
-- local function MoveMicroMenu()
--   for i=1, #MICRO_BUTTONS do
--     _G[MICRO_BUTTONS[i]]:SetScale(0.88)
--   end

--   CharacterMicroButton:ClearAllPoints()
--   CharacterMicroButton:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -293,0)
-- end

-- MoveMicroMenu()

-- PREVENT REPOSITIONING WHEN LEAVE THE VEHICLE
-- local MicroMenuMove = CreateFrame("FRAME")
-- MicroMenuMove:RegisterEvent("UNIT_EXITED_VEHICLE")
-- MicroMenuMove:SetScript("OnEvent", MoveMicroMenu)

-- Class colors in target name background
local frame = CreateFrame("FRAME")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
frame:RegisterEvent("UNIT_FACTION")

local function eventHandler(self, event, ...)
 local unitid = ...

 if (event == "UNIT_FACTION" and unitid ~= "target" and unitid ~= "focus") then return end

 if UnitIsPlayer("target") then
 _, class = UnitClass("target")
 c = RAID_CLASS_COLORS[class]
 TargetFrameNameBackground:SetVertexColor(c.r, c.g, c.b )
 end
 if UnitIsPlayer("focus") then
 _, class = UnitClass("focus")
 c = RAID_CLASS_COLORS[class]
 FocusFrameNameBackground:SetVertexColor(c.r, c.g, c.b )
 end
end

frame:SetScript("OnEvent", eventHandler)

-- Class colors in focus name background
local frame = CreateFrame("FRAME")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
frame:RegisterEvent("UNIT_FACTION")

local function eventHandler(self, event, ...)
 local unitid = ...

 if (event == "UNIT_FACTION" and unitid ~= "focus") then return end

 if UnitIsPlayer("focus") then
 _, class = UnitClass("focus")
 c = RAID_CLASS_COLORS[class]
 FocusFrameNameBackground:SetVertexColor(c.r, c.g, c.b)
 end
end
frame:SetScript("OnEvent", eventHandler)

-- Brighter targetname and focusname textures (fix)
for _, BarTextures in pairs({TargetFrameNameBackground, FocusFrameNameBackground})
do
 BarTextures:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
end

-- CAST BAR TIMER
CastingBarFrame.timer = CastingBarFrame:CreateFontString(nil);
CastingBarFrame.timer:SetFont(STANDARD_TEXT_FONT,12,"OUTLINE");
CastingBarFrame.timer:SetPoint("TOP", CastingBarFrame, "BOTTOM", 0, -5);
CastingBarFrame.update = .1;

hooksecurefunc("CastingBarFrame_OnUpdate", function(self, elapsed)
  if not self.timer then return end
  if self.update and self.update < elapsed then
    if self.casting then
      self.timer:SetText(format("%2.1f/%1.1f", max(self.maxValue - self.value, 0), self.maxValue))
    elseif self.channeling then
      self.timer:SetText(format("%.1f", max(self.value, 0)))
    else
      self.timer:SetText("")
    end
    self.update = .1
  else
    self.update = self.update - elapsed
  end
end)

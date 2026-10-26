--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/ammo/att_ammo_db.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_ammo"
ATTACHMENT.Name = "Dragons Breath"
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/romeo870/icon_attachment_sh_romeo870_caldb.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:OnImpact(weapon, dmgInfo, tr)
    BaseClass.OnImpact(self, weapon, dmgInfo, tr)

    if (SERVER && table.HasValue(weapon.FireSurfaces, tr.MatType)) then
        tr.Entity:Ignite(2)
    end

    ParticleEffect("AC_muzzle_shotgun_db", tr.HitPos, tr.HitNormal:Angle())
    util.Decal("Dark", tr.HitPos + tr.HitNormal, tr.HitPos - (tr.HitNormal * 3), {weapon, weapon:GetOwner()})
    weapon:MakeLight(tr.HitPos, Color(255, 50, 0), 2, CurTime() + 1)

    dmgInfo:SetDamageType(dmgInfo:GetDamageType())
end

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon:doDBStats()
end

function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
    weapon.Projectile = nil
end
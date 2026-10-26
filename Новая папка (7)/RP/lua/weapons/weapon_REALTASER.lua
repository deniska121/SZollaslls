SWEP.Gun="weapon_taser"
SWEP.Base="weapon_base"
SWEP.PrintName="Taser"
SWEP.Slot=1
SWEP.SlotPos=2
SWEP.DrawAmmo=true
SWEP.BounceWeaponIcon=false
SWEP.DrawCrosshair=true
SWEP.ViewModel="models/realistic_police/taser/c_taser.mdl"
SWEP.ViewModelFOV=60
SWEP.WorldModel="models/realistic_police/taser/w_taser.mdl"
SWEP.HoldType="revolver"
SWEP.UseHands=true
SWEP.Weight=0
SWEP.AutoSwitchTo=true
SWEP.Spawnable=true
SWEP.Author="Yetg"
SWEP.Purpose="Easily apprehend criminals, or sadistically watch people writhe in pain i guess."
SWEP.Instructions="Immobilize things you dislike."
SWEP.Category="YetgStuff"
SWEP.Primary.Spread=0.1
SWEP.Primary.NumberofShots=1
SWEP.Primary.Automatic=false
SWEP.Primary.Recoil=.2
SWEP.Primary.Delay=0.1
SWEP.Primary.Force=100
SWEP.Primary.Sound=Sound("")
SWEP.Primary.ClipSize=1
SWEP.Primary.DefaultClip=2
SWEP.Primary.Ammo="Pistol"
SWEP.Secondary.ClipSize=-1
SWEP.Secondary.DefaultClip=-1
SWEP.Secondary.Ammo=""
SWEP.SelectIcon="hud/weaponicons/taser"

local ImmuneJobs={TEAM_MAYOR,TEAM_CHIEF}

if SERVER then
	util.AddNetworkString("taser_fire")
end

function SWEP:Initialize()
	self:SetWeaponHoldType("revolver")
end

if CLIENT then
	net.Receive("taser_fire",function()
		local p=net.ReadEntity()
		local sp=net.ReadVector()
		local ep=net.ReadVector()
		if IsValid(p) then
			p:EmitSound("csgo/taser/taser_shoot.wav",75,100,0.2)
			local ed=EffectData()
			ed:SetOrigin(ep)
			ed:SetStart(sp)
			ed:SetAttachment(1)
			ed:SetEntity(self)
			util.Effect("ToolTracer",ed)
		end
	end)
end

function SWEP:PrimaryAttack()
	if CLIENT then
		net.Start("taser_fire")
			net.WriteEntity(self.Owner)
			local startPos=self.Owner:GetShootPos()
			local att=self.Owner:LookupAttachment("muzzle")
			if att and att>0 then
				local a=self.Owner:GetAttachment(att)
				if a then startPos=a.Pos end
			end
			net.WriteVector(startPos)
			net.WriteVector(startPos+self.Owner:GetAimVector()*300)
		net.SendToServer()
		return
	end
	if self.Weapon:Clip1()==0 then
		sound.Play("Weapon_Pistol.Empty",self.Owner:GetPos(),75,100,1)
		return
	end
	if not self:CanPrimaryAttack() then return end
	self.Owner:EmitSound("csgo/taser/taser_shoot.wav",75,100,0.2)
	local startPos=self.Owner:GetShootPos()
	local att=self.Owner:LookupAttachment("muzzle")
	if att and att>0 then
		local a=self.Owner:GetAttachment(att)
		if a then startPos=a.Pos end
	end
	local tr={
		start=startPos,
		endpos=startPos+self.Owner:GetAimVector()*300,
		mins=Vector(-2,-2,-2),
		maxs=Vector(2,2,2),
		filter=self.Owner
	}
	self:GetOwner():LagCompensation(true)
	local t=util.TraceHull(tr)
	self:GetOwner():LagCompensation(false)
	local p=t.Entity
	if IsValid(p) and p:IsPlayer() and p:Alive() then
		if ImmuneJobs then
			if table.HasValue(ImmuneJobs,p:Team()) then return end
		end
		if AddShock then
			AddShock(p,90)
		else
			local cur=p:GetNWFloat("Shock",0)
			p:SetNWFloat("Shock",math.Clamp(cur+90,0,200))
		end
	end
	self:TakePrimaryAmmo(1)
	self:SetNextPrimaryFire(CurTime()+self.Primary.Delay)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	net.Start("taser_fire")
		net.WriteEntity(self.Owner)
		net.WriteVector(startPos)
		net.WriteVector(t.HitPos)
	net.Broadcast()
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime()+9999999)
	timer.Create("taser_anim"..self:GetOwner():EntIndex(),self:SequenceDuration()*0.5,1,function()
		if IsValid(self) and IsValid(self:GetOwner()) then
			if self:GetOwner():GetActiveWeapon()==self then
				self:SendWeaponAnim(ACT_VM_IDLE)
				self:SetNextPrimaryFire(CurTime())
			end
		end
	end)
	return true
end

function SWEP:Holster()
	return true
end

function SWEP:Reload()
	local w=self:GetOwner():GetActiveWeapon()
	if not IsValid(w) then return -1 end
	local a=self:GetOwner():GetAmmoCount(w:GetPrimaryAmmoType())
	if self:Clip1()==0 and a~=0 then
		self.Weapon:EmitSound("stungun/taser_reload.mp3")
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
	end
end

function SWEP:DrawWeaponSelection(x,y,wide,tall,alpha)
	if self.SelectIcon then
		surface.SetDrawColor(255,255,255,255)
		surface.SetTexture(surface.GetTextureID(self.SelectIcon))
		surface.DrawTexturedRect(x+20,y+30,200,100)
	else
		draw.SimpleText(self.IconLetter,self.SelectFont,x+wide/2,y+tall*0.2,Color(255,210,0,alpha),TEXT_ALIGN_CENTER)
	end
	y=y+10
	x=x+10
	wide=wide-20
	self:PrintWeaponInfo(x+wide+20,y+tall*0.95,alpha)
end

function SWEP:Precache()
	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheModel(self.ViewModel)
	util.PrecacheModel(self.WorldModel)
end

local ver=1.0
concommand.Add("taser_info",function()
	for _,m in pairs({
		"https://steamcommunity.com/sharedfiles/filedetails/?id=2595774444 created by Haze_of_dream",
		"",
		"Contact at: ",
		"STEAM_0:1:75838598",
		"https:/steamcommunity.com/id/Haze_of_dream",
		"",
		string.format("Taser Version: %s",ver)
	}) do print(m) end
end)

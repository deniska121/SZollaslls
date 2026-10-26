-- "addons\\weapons\\lua\\entities\\mg_sniper_bullet\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "mg_bullet"

game.AddParticles("particles/mw19_attachments.pcf")
PrecacheParticleSystem("bullet_sniper_smoke")
PrecacheParticleSystem("bullet_sniper_tracer")
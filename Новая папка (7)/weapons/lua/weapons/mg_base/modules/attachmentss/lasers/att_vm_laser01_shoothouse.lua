-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\lasers\\att_vm_laser01_shoothouse.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_laser01"
ATTACHMENT.Name = ".red Swift"
ATTACHMENT.Laser = {
    BeamMaterial = Material("mw19_laserbeam.vmt"),
    DotMaterial = Material("mg/sprites/shoothouselaser.vmt"),
    BeamSize = 15,
    BeamWidth = 1,
    DotSize = 2,
    Color = Color(255, 0, 255, 255),
    Attachment = "laser"
}
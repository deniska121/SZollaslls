--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/mc_phone/modules/web_gov.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--

McPhone.WebModules["gov"] = {}
McPhone.WebModules["gov"].name = "Union News"
McPhone.WebModules["gov"].url = "https://union.nyc.gov"

if SERVER then return end

local got_cons = false
local got_pdd = false

McPhone.WebModules["gov"].OpenWebmenu = function()
	if not McPhone.ActiveWeb then return end
	McPhone.ActiveWeb.WebAdress:SetValue(McPhone.WebModules["gov"].url)

	McPhone.UpdateWeb(function(p, w, h)
		local html = vgui.Create("DHTML", p)
		html:SetSize(w, h)
		html:SetPos(0, 0)
		html:OpenURL("http://cityrp.macnco.one/test/index.html")
		html:AddFunction( "JavaScriptBridge", "ButtonClicked", function( str )
			if got_cons then return end
			got_cons = true
			DarkRP.PlayerBuyItem(nil, "Junk", "const", 1, true)
		end)
		html:AddFunction( "JavaScriptBridge", "ButtonPDD", function( str )
			if got_pdd then return end
			got_pdd = true
			DarkRP.PlayerBuyItem(nil, "Junk", "pdd", 1, true)
		end)

		function html:OnDocumentReady(url)
			if string.find(url, "cityrp.macnco.one/video") then
				gui.OpenURL(url)
				McPhone.WebModules["gov"].OpenWebmenu()
			end

			local mayors = team.GetPlayers(15)

			if #mayors < 1 or not mayors[1] or not IsValid(mayors[1]) then return end
			local num = McPhone.NumberChar(mayors[1])
			html:RunJavascript( [[document.getElementById("steamname").innerHTML = "Районный администратор - ]] .. mayors[1]:FullName() .. " ( " .. string.sub(num, 1, 3) .. "-" .. string.sub(num, 4, 7) .. [[ )";]] )
		end
	end)
end

McPhone.WebModules["screamer"] = {}
McPhone.WebModules["screamer"].name = "screamer"
McPhone.WebModules["screamer"].url = "https://screamer.com"

McPhone.WebModules["microniq"] = {}
McPhone.WebModules["microniq"].name = "microniq"
McPhone.WebModules["microniq"].url = "https://microniq.com"

McPhone.WebModules["radiomind"] = {}
McPhone.WebModules["radiomind"].name = "radiomind"
McPhone.WebModules["radiomind"].url = "http://radiomind.info"

McPhone.WebModules["overloaded"] = {}
McPhone.WebModules["overloaded"].name = "overloaded"
McPhone.WebModules["overloaded"].url = "http://overloaded.net"

McPhone.WebModules["microniq"].OpenWebmenu = function()
	if not McPhone.ActiveWeb then return end
	McPhone.ActiveWeb.WebAdress:SetValue(McPhone.WebModules["microniq"].url)

	McPhone.UpdateWeb(function(p, w, h)
		local html = vgui.Create("DHTML", p)
		html:SetSize(w, h)
		html:SetPos(0, 0)
		html:OpenURL("http://cityrp.macnco.one/microniq/index.html")

		function html:OnDocumentReady(url)
		end
	end)
end

McPhone.WebModules["screamer"].OpenWebmenu = function()
	if not McPhone.ActiveWeb then return end
	McPhone.ActiveWeb.WebAdress:SetValue(McPhone.WebModules["screamer"].url)

	McPhone.UpdateWeb(function(p, w, h)
		local html = vgui.Create("DHTML", p)
		html:SetSize(w, h)
		html:SetPos(0, 0)
		html:OpenURL("http://cityrp.macnco.one/screamer/index.html")

		function html:OnDocumentReady(url)
		end
	end)
end

McPhone.WebModules["radiomind"].OpenWebmenu = function()
	if not McPhone.ActiveWeb then return end
	McPhone.ActiveWeb.WebAdress:SetValue(McPhone.WebModules["radiomind"].url)

	McPhone.UpdateWeb(function(p, w, h)
		local html = vgui.Create("DHTML", p)
		html:SetSize(w, h)
		html:SetPos(0, 0)
		html:OpenURL("http://cityrp.macnco.one/radiomind/index.html")

		function html:OnDocumentReady(url)
		end
	end)
end

McPhone.WebModules["overloaded"].OpenWebmenu = function()
	if not McPhone.ActiveWeb then return end
	McPhone.ActiveWeb.WebAdress:SetValue(McPhone.WebModules["overloaded"].url)

	McPhone.UpdateWeb(function(p, w, h)
		local html = vgui.Create("DHTML", p)
		html:SetSize(w, h)
		html:SetPos(0, 0)
		html:OpenURL("http://cityrp.macnco.one/overloaded/forums.html")

		function html:OnDocumentReady(url)
			if url == "http://cityrp.macnco.one/overloaded/busted.html" then
				net.Start("McPhone.CallExtraNumber")
					net.WriteUInt(1, 2)
				net.SendToServer()
			end
		end
	end)
end
-- "addons\\mc_ranks\\lua\\mc_ranks\\core\\sh_util.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╦═══╗───────────────────────
-- ║║╚╝║║╔═╗║╔═╗║───────────────────────
-- ║╔╗╔╗║╚═╝║╚══╗──By MacTavish <3──────
-- ║║║║║║╔╗╔╩══╗║───────────────────────
-- ║║║║║║║║╚╣╚═╝║───────────────────────
-- ╚╝╚╝╚╩╝╚═╩═══╝───────────────────────

function MRS.TableCompress(data)
	local json_data = util.TableToJSON(data, false)
	local compressed_data = util.Compress(json_data)
	local bytes_number = string.len(compressed_data)

	return compressed_data, bytes_number
end

-- Thx wiki
function MRS.StringFormat( fmt, ... )
	local arg = { ... }
	return fmt:gsub( "{(%d+)}", function( i ) return arg[ tostring( i ) + 1 ] end )
end

function MRS.TableDecompress(compressed_data)
	local json_data = util.Decompress(compressed_data)
	local data = util.JSONToTable(json_data)

	return data
end

function MRS.CheckID(id)
	if tonumber(id) then return false end
	return id
end

function MRS.PlayerID(ply)
	return "MRS" .. DarkRP.CharacterID(ply)
end

function MRS.IsCharSystemOn()
	return VoidChar or ix or Aden_DC
end

function MRS.FindPlayer(info)
	if not info or info == "" then return nil end
	local pls = player.GetAll()

	for k = 1, #pls do -- Proven to be faster than pairs loop.
		local v = pls[k]
		if tonumber(info) == v:UserID() then
			return v
		end

		if info == v:SteamID() then
			return v
		end

		if string.find(string.lower(v:Nick()), string.lower(tostring(info)), 1, true) ~= nil then
			return v
		end

		if string.find(string.lower(v:SteamName()), string.lower(tostring(info)), 1, true) ~= nil then
			return v
		end
	end
	return nil
end

-- concommand.Add("mrs_export", function(pl, cmd, args)
-- 	if not file.Exists("mrs_savedranks", "DATA") then
-- 		file.CreateDir("mrs_savedranks")
-- 		MsgC(Color(0, 255, 0), "[MRS] mrs_savedranks dir created \n")
-- 	end

-- 	for k, v in ipairs(MRS.Ranks) do
-- 		local json = util.TableToJSON(v, true)
-- 		file.Write("mrs_savedranks/" .. k .. ".txt", json)

-- 		print("File saved to DATA folder as " .. k .. ".txt")
-- 	end
-- end)
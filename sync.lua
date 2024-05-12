local Net = _G.LuaNetworking
local host_drama = string.format("%.2f", managers.groupai:state()._drama_data.amount) or 100

if Network:is_server() then Net:SendToPeers("this_sync_test", tostring(host_drama)) end
--managers.chat:send_message(ChatManager.GAME, managers.network.account:username() or "Offline", "self working detect" .. host_drama)

Hooks:Add("NetworkReceivedData", "NetworkReceivedDataSyncTest", function(sender, id, data)
	local peer = Net:GetPeers()[sender]
	if id == "this_sync_test" and peer then
		--managers.chat:send_message(ChatManager.GAME, managers.network.account:username() or "Offline", data)
		--managers.chat:send_message(ChatManager.GAME, managers.network.account:username() or "Offline", "myside drama:"..managers.groupai:state()._drama_data.amount)
		if not Network:is_server() then managers.groupai:state()._drama_data.amount = data end
	end
end)
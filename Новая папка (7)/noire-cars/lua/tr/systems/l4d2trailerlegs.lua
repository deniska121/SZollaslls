return {
    Connect = function(ventity)
        if ventity.connection and IsValid(ventity.connection.ent) then
            local trailer = ventity.connection.ent		
			
			trailer.Target = 1
        end
    end,
    Disconnect = function(ventity)
        if ventity.connection and IsValid(ventity.connection.ent) then
            local trailer = ventity.connection.ent
			
			trailer.Target = 0
        end
    end
}

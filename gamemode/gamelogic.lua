if SERVER then
    bombs = {}
    
    function AddBomb(name)
        table.insert(bombs, name)
    end
    
    function DelBomb(name)
        table.remove(bombs, table.KeyFromValue(bombs, name))
    end
end
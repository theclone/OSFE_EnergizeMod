function UP_Energize(spell)
    local amount = GetAmount(spell)
    for _, target in ipairs(GetTarget(spell)) do
        UP_ApplyEnergize(target, amount)
    end
end
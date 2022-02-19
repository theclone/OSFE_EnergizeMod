function UP_Energize(spell)
    local duration = GetDuration(spell)
    local amount = GetAmount(spell)
    for _, target in ipairs(GetTarget(spell)) do
        AddEffect(target, "UP_Energize", duration, amount + GetEffectAmount(spell.being, "UP_Energize"))
        Log(string.format("attempted to apply upgrade, upgrade now at %f", GetEffectAmount(target, "UP_Energize")))
    end
end
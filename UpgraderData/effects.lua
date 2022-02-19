UP_ThunderSpells = {
    ["StormThunder"] = true, 
    ["Thunder"] = true, 
    ["ThunderLight"] = true,
    ["HitThunder"] = true,
    ["Sunder"] = true,
    ["Ambush"] = true
}

function UP_EnergizeCheck(spell)
    Log("check for upgrade");
    local upgradeAmount = GetEffectAmount(spell.being, "UP_Energize");
    if (upgradeAmount > 0) then
        Log("attempt to upgrade!");
        tempUpgradedSpell = spell.being.spellToCast.Clone();
        tempUpgradedSpell.Set(spell.being.spellToCast.being, true);
        for _, efApp in ipairs(spell.being.spellToCast.efApps) do
            if (efApp.effect == Effect.Consume) then
                spell.being.spellToCast.consume = true
                break
            end
        end

        ApplyRandomUpgrade(tempUpgradedSpell, {});

        spell.being.lastSpellText.textBox.SetText(tempUpgradedSpell.nameString);
        local cardtridgeEntry = spell.being.duelDisk.castSlots[spell.being.spellToCast.castSlotNum];
        spell.being.spellToCast = tempUpgradedSpell;

        if (upgradeAmount > 1) then
            AddEffect(spell.being, "UP_Energize", duration, upgradeAmount - 1);
        else
            RemoveEffect(spell.being, "UP_Energize");
        end
    end
end

function UP_ManaCheckEnergize(spell)
    Log("check for mana");
    if (spell.being.spellToCast.mana >= GetAmount(spell)) then
        --waiting for spell to cast before giving upgrade
        local beingRef = spell.being;
        WaitForSeconds(spell, spell.being.spellToCast.castDelay);
        AddEffect(beingRef, "UP_Energize", 0, 1 + GetEffectAmount(beingRef, "UP_Energize"))
        Log(string.format("attempted to apply upgrade, upgrade now at %f", GetEffectAmount(beingRef, "UP_Energize")))
    end
end

function UP_ThunderCheckEnergize(item)
    Log("check for thunder");
    if (UP_ThunderSpells[item.being.battleGrid.lastTargetHit.lastSpellHit.itemID] == true) then
        AddEffect(item.being, "UP_Energize", 0, 1 + GetEffectAmount(item.being, "UP_Energize"))
        Log(string.format("attempted to apply upgrade, upgrade now at %f", GetEffectAmount(item.being, "UP_Energize")))
    end
end
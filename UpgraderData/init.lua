function Init()
    MakeSprite("EnergizeEffectIcon.png", PATH, "EnergizeEffectIcon");
    while (GetSprite("EnergizeEffectIcon") == null) do
        WaitForFrames(1);
    end
    NewEffect("UP_Energize", "EnergizeEffectIcon");

    AddEffectTooltip("UP_Energize", "Energize", "Next spell cast will have an extra random valid <hg>upgrade</hg> applied.");

    AddUpgrade("UP_EnergizeUpgrade","UP","Energize","UP_EnergizeSpellCheck","UP_EnergizeUpgradeEffect")
    AddHook(FTrigger.OnPlayerSpellCast, "UP_EnergizeCheck");
    Log("added upgrade inits");
end

function UP_EnergizeSpellCheck(spell)
    return true;
end

function UP_EnergizeUpgradeEffect(spell)
    AddXMLToSpell(spell, "<OnCast amount=\"1\" duration=\"0\" target=\"Self\" value=\"UP_Energize\">Lua</OnCast>");
end
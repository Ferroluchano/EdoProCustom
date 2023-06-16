-- Library Dragonmaid
function c999000499.initial_effect(c)
    -- Efecto de invocación especial
    local e1 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(999000499, 0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_HAND)
    e1:SetCountLimit(1, 999000499)
    e1:SetCost(c200000002.spcost)
    e1:SetTarget(c200000002.sptarget)
    e1:SetOperation(c200000002.spoperation)
    c:RegisterEffect(e1)

    -- Efecto de devolución
    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(999000499, 1))
    e2:SetCategory(CATEGORY_TOHAND + CATEGORY_SEARCH)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1, 999000499)
    e2:SetTarget(c200000002.searchtarget)
    e2:SetOperation(c200000002.searchoperation)
    c:RegisterEffect(e2)
end

function c999000499.spcost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.CheckReleaseGroupCost(tp, Card.IsRace, 1, false, nil, RACE_DRAGON)
    end
    local g = Duel.SelectReleaseGroupCost(tp, Card.IsRace, 1, 1, false, nil, RACE_DRAGON)
    Duel.Release(g, REASON_COST)
end

function c999000499.sptarget(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.GetLocationCount(tp, LOCATION_MZONE) > 0
            and e:GetHandler():IsCanBeSpecialSummoned(e, 0, tp, false, false, POS_FACEUP_DEFENSE, tp)
    end
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, e:GetHandler(), 1, 0, 0)
end

function c999000499.spoperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if not c:IsRelateToEffect(e) then
        return
    end
    if Duel.SpecialSummon(c, 0, tp, tp, false, false, POS_FACEUP_DEFENSE) == 0 then
        return
    end
    -- Efecto de búsqueda
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(c999000499.searchcondition)
    e1:SetTarget(c999000499.searchtarget)
    e1:SetOperation(c999000499.searchoperation)
    e1:SetReset(RESET_EVENT + RESETS_STANDARD)
    c:RegisterEffect(e1)

    -- Efecto de devolución y Invocación Especial
    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(999000499, 2))
    e2:SetCategory(CATEGORY_TOHAND + CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1

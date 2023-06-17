-- Nombre de la carta
-- Descripción de la carta

function c999000299.initial_effect(c)
    -- Efecto principal
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_POSITION)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetCondition(c999000299.condition)
    e1:SetCost(c999000299.cost)
    e1:SetTarget(c999000299.target)
    e1:SetOperation(c999000299.operation)
    c:RegisterEffect(e1)
end

-- Verifica si puedes activar el efecto una vez por turno y si la carta está en el campo
function c999000299.condition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp and e:GetHandler():IsFaceup()
end

-- Paga el costo de enviar una carta de la mano al Cementerio
function c999000299.cost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost, tp, LOCATION_HAND, 0, 1, nil) end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TOGRAVE)
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToGraveAsCost, tp, LOCATION_HAND, 0, 1, 1, nil)
    Duel.SendtoGrave(g, REASON_COST)
end

-- Elige y cambia de posición a un monstruo enemigo
function c999000299.target(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then return Duel.IsExistingTarget(Card.IsFaceup, 1 - tp, LOCATION_MZONE, 0, 1, nil) end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_POSCHANGE)
    local g = Duel.SelectTarget(tp, Card.IsFaceup, 1 - tp, LOCATION_MZONE, 1, 1, nil)
    Duel.SetOperationInfo(0, CATEGORY_POSITION, g, 1, 0, 0)
end

-- Cambia la posición del monstruo seleccionado
function c999000299.operation(e, tp, eg, ep, ev, re, r, rp)
    local tc = Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and tc:IsAttackPos() then
        Duel.ChangePosition(tc, POS_FACEUP_DEFENSE)
    end
end
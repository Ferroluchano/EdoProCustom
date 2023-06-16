-- Library Dragonmaid
-- ID: 999000499
-- Tipo: Dragón/Normal
-- Atributo: Fuego
-- Nivel: 4
-- ATK: 1600
-- DEF: 1200

function c999000499.initial_effect(c)
    -- Efecto de Invocación
    -- Si esta carta es Invocada de Modo Normal o Especial, puedes seleccionar 1 monstruo "Dragonmaid" de Nivel 4 o menor en tu Cementerio y añadirlo a tu mano, pero no puedes activar sus efectos hasta el comienzo de la Fase de Batalla.
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_TOHAND)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetProperty(EFFECT_FLAG_DELAY)
    e1:SetCondition(c999000499.thCondition)
    e1:SetTarget(c999000499.thTarget)
    e1:SetOperation(c999000499.thOperation)
    c:RegisterEffect(e1)
    local e2 = e1:Clone()
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e2)

    -- Efecto de Retorno
    -- Puedes devolver esta carta a la mano y, si lo haces, Invoca de Modo Especial 1 monstruo "Dragonmaid" de Nivel 7 o mayor desde tu mano o Cementerio.
    local e3 = Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCountLimit(1)
    e3:SetCost(c999000499.rtnCost)
    e3:SetTarget(c999000499.rtnTarget)
    e3:SetOperation(c999000499.rtnOperation)
    c:RegisterEffect(e3)
end

-- Efecto de Invocación
function c999000499.thCondition(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsPreviousLocation(LOCATION_HAND)
end

function c999000499.thFilter(c)
    return c:IsSetCard(0x133) and c:IsLevelBelow(4) and c:IsRace(RACE_DRAGON) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsAbleToHand()
end

function c999000499.thTarget(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c999000499.thFilter,tp,LOCATION_GRAVE,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end

function c999000499.thOperation(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c999000499.thFilter,tp,LOCATION_GRAVE,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
        local tc=g:GetFirst()
        if tc:IsLocation(LOCATION_HAND) then
            tc:RegisterFlagEffect(999000499,RESET_EVENT+RESETS_STANDARD,0,0)
        end
    end
end

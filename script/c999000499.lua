-- Library Dragonmaid
-- ID: 999000499
-- Tipo: Dragón
-- Atributo: Luz
-- ATK: 700
-- DEF: 1800

function c999000499.initial_effect(c)
    -- Efecto de búsqueda desde el Cementerio
    local e1 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(999000499,0))
    e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetProperty(EFFECT_FLAG_DELAY)
    e1:SetTarget(c999000499.searchTarget)
    e1:SetOperation(c999000499.searchOperation)
    c:RegisterEffect(e1)

    -- Efecto de Invocación Especial de monstruos "Dragonmaid" de Nivel 7 o mayor
    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(999000499,1))
    e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1,999000499)
    e2:SetTarget(c999000499.spSummonTarget)
    e2:SetOperation(c999000499.spSummonOperation)
    c:RegisterEffect(e2)
end

function c999000499.filter(c)
    return c:IsSetCard(0x133) and c:IsLevelBelow(4) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end

function c999000499.searchTarget(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c999000499.filter,tp,LOCATION_GRAVE,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end

function c999000499.searchOperation(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c999000499.filter,tp,LOCATION_GRAVE,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end

function c999000499.spSummonFilter(c,e,tp)
    return c:IsSetCard(0x133) and c:IsLevelAbove(7) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c999000499.spSummonTarget(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c999000499.spSummonFilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp)
        and e:GetHandler():IsAbleToHand() end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end

function c999000499.spSummonOperation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) and Duel.SendtoHand(c,nil,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_HAND) then
       

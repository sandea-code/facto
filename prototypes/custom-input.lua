-- SpeedRail :: горячие клавиши (CustomInputPrototype)
-- https://lua-api.factorio.com/latest/prototypes/CustomInputPrototype.html
--   key_sequence :: string (обязательно), consuming :: ConsumingType,
--   localised_name, action (не задаём -> просто событие on_custom_input).
-- Событие: defines.events.on_custom_input -> { input_name, player_index }.

local C = require("constants")

data:extend({
  {
    type = "custom-input",
    name = C.input_open_name,
    key_sequence = "CONTROL + SHIFT + L",
    consuming = "game-only",
    localised_name = { "controls.speedrail-open-limit-gui" },
  },
  {
    -- Быстро получить инструмент массового применения в курсор.
    type = "custom-input",
    name = C.input_give_tool,
    key_sequence = "CONTROL + SHIFT + K",
    consuming = "game-only",
    localised_name = { "controls.speedrail-give-limit-tool" },
  },
})

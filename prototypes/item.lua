-- SpeedRail :: предмет-инструмент (ТЗ 1.1 "отдельный инструмент", ТЗ раздел 3 "массовое применение")
--
-- SelectionToolPrototype 2.x: обязательны `select` и `alt_select`
-- (SelectionModeData: border_color, cursor_box_type, mode, entity_filters...).
-- https://lua-api.factorio.com/latest/prototypes/SelectionToolPrototype.html
-- https://lua-api.factorio.com/latest/types/SelectionModeData.html

local C = require("constants")

data:extend({
  {
    type = "selection-tool",
    name = C.tool_item_name,
    localised_name = { "item-name.speedrail-limit-tool" },
    localised_description = { "item-description.speedrail-limit-tool" },
    icon = "__speedrail__/graphics/speed-limit-area-tool.png",
    icon_size = 64,
    subgroup = "transport",
    order = "c[rail]-z[speed-limit-tool]",
    stack_size = 1,
    flags = { "hidden", "not-in-made-in", "not-in-bonus-gui", "only-in-cursor", "spawnable" },

    -- ЛКМ: выделить область -> задать лимит всем блокам, рельсы которых попали
    -- в выделение (массовое применение для мегабаз).
    select = {
      border_color = { r = 0.95, g = 0.75, b = 0.15, a = 1 },
      cursor_box_type = "copy",
      mode = { "any-entity" },
      entity_type_filters = { "straight-rail", "half-diagonal-rail", "curved-rail-a",
                              "curved-rail-b", "legacy-straight-rail", "legacy-curved-rail",
                              "rail-signal", "rail-chain-signal", "train-stop" },
    },

    -- ПКМ (alt): сбросить выделенное к ванильному лимиту (1.0x).
    alt_select = {
      border_color = { r = 0.35, g = 0.75, b = 1.0, a = 1 },
      cursor_box_type = "not-allowed",
      mode = { "any-entity" },
      entity_type_filters = { "straight-rail", "half-diagonal-rail", "curved-rail-a",
                              "curved-rail-b", "legacy-straight-rail", "legacy-curved-rail",
                              "rail-signal", "rail-chain-signal", "train-stop" },
    },
  },
})

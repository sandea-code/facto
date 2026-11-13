-- ============================================================================
--  SpeedRail :: общие константы (data stage + control stage)
--
--  ВАЖНО: этот файл НЕ должен обращаться к `data`, `script`, `game`, `defines`
--  и прочим объектам стадий — он загружается и в data-стадии, и в runtime.
-- ============================================================================

local C = {}

-- имена прототипов
C.invisible_rail_name = "speedrail-invisible-rail"
C.skid_mark_name      = "speedrail-skid-mark"
C.tool_item_name      = "speedrail-limit-tool"
C.shortcut_name       = "speedrail-limit-tool-shortcut"
C.gui_frame_name      = "speedrail_limit_frame"
C.input_open_name     = "speedrail-open-limit-gui"
C.input_give_tool     = "speedrail-give-limit-tool"

-- типы сущностей, на которых можно задать лимит "для блока"
C.signal_types = { ["rail-signal"] = true, ["rail-chain-signal"] = true }

-- все типы рельсов (2.0 + legacy), используется для поиска "чужих" рельсов
C.rail_types = {
  ["straight-rail"]            = true,
  ["half-diagonal-rail"]       = true,
  ["curved-rail-a"]            = true,
  ["curved-rail-b"]            = true,
  ["rail-ramp"]                = true,
  ["elevated-straight-rail"]   = true,
  ["elevated-half-diagonal-rail"] = true,
  ["elevated-curved-rail-a"]   = true,
  ["elevated-curved-rail-b"]   = true,
  ["legacy-straight-rail"]     = true,
  ["legacy-curved-rail"]       = true,
  [C.invisible_rail_name]      = true,
}

-- типы рельсов, которые считаются поворотом (кривая), и их "безопасный" коэффициент
-- скорости относительно базовой скорости состава. Значения вынесены в настройки мода,
-- здесь — только имена прототипов, чтобы их можно было переиспользовать в data-стадии.
C.curve_types = {
  ["curved-rail-b"]          = "tight",   -- самая тесная кривая (90 градусов)
  ["curved-rail-a"]          = "wide",    -- плавная кривая
  ["legacy-curved-rail"]     = "tight",   -- legacy-кривая = аналог 90 градусов
  ["half-diagonal-rail"]     = "half",    -- полудиагональный участок
  ["rail-ramp"]              = "ramp",    -- подъём/съезд на эстакаду
  ["elevated-curved-rail-b"] = "tight",
  ["elevated-curved-rail-a"] = "wide",
}

-- физика: перевод скорости игры (тайлов/тик) в км/ч для отображения в GUI
-- 1 тайл = 1 метр, 1 тик = 1/60 секунды  ->  v[km/h] = v[tile/tick] * 60 * 3.6
C.SPEED_TO_KMH = 60 * 3.6

-- служебные
C.tag_key = "speedrail_factor_x100" -- ключ в LuaEntity::tags (кэш лимита рельса)

return C

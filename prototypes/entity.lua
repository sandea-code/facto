-- ============================================================================
--  SpeedRail :: прототипы сущностей
--
--  Проверялось по документации Factorio 2.1.x:
--   * StraightRailPrototype  https://lua-api.factorio.com/latest/prototypes/StraightRailPrototype.html
--       - pictures / fence_pictures / walking_sound / removes_soft_decoratives — optional
--         (наследуются от RailPrototype);
--       - collision_mask — optional, CollisionMaskConnector;
--       - collision_box ЖЁСТКО зашит в движке: {{-0.7,-0.99},{0.7,0.99}}
--         (см. примечание на странице StraightRailPrototype и комментарий в
--         base/prototypes/entity/trains.lua: "collision box is hardcoded for rails"),
--         поэтому в прототипе указывается только "строительный" бокс, как в ваниле.
--   * EntityPrototypeFlag    https://lua-api.factorio.com/latest/concepts/EntityPrototypeFlag.html
--       - "not-selectable-in-game", "not-blueprintable", "not-deconstructable",
--         "not-on-map", "not-flammable", "not-repairable", "no-copy-paste",
--         "not-upgradable", "not-in-kill-statistics" — все существуют.
--   * Имена слоёв коллизий 2.x (base/prototypes/collision-layers.lua):
--       ground_tile, water_tile, resource, doodad, floor, rail, transport_belt,
--       item, ghost, object, player, car, TRAIN, elevated_rail, elevated_train,
--       empty_space, lava_tile, meltable, rail_support, trigger_target, cliff.
--       В 1.x слой назывался "train-layer", в 2.x ключ маски — "train".
--   * CorpsePrototype        https://lua-api.factorio.com/latest/prototypes/CorpsePrototype.html
--       - time_before_removed :: uint32 "Time in ticks this corpse lasts",
--         auto_setup_collision_box, remove_on_tile_placement, selectable_in_game,
--         final_render_layer, collision_mask — всё optional/доступно.
-- ============================================================================

local C = require("constants")

data:extend({

  -- --------------------------------------------------------------------------
  --  НЕВИДИМЫЙ РЕЛЬС для инерционного пробега сошедшего состава (ТЗ 1.3).
  --
  --  Критично:
  --   * нет `pictures`                      -> нет ни текстур, ни иконок на карте;
  --   * нет `minable`, нет `placeable_by`,
  --     нет предмета и рецепта              -> не добывается, не даёт ресурсов,
  --                                            не копируется в чертёж;
  --   * not-selectable-in-game /
  --     not-blueprintable /
  --     not-deconstructable                 -> прямое требование ТЗ;
  --   * hidden + not-on-map +
  --     hidden_in_factoriopedia             -> не виден в списках/Factoriopedia;
  --   * collision_mask = train (+ тайлы)    -> движок пропускает поезд по инерции,
  --                                            но рельс не мешает строить здания;
  --   * нет `corpse`                        -> после программного уничтожения
  --                                            не остаётся НИКАКИХ объектов
  --                                            (ТЗ, раздел 2, п.2).
  -- --------------------------------------------------------------------------
  {
    type = "straight-rail",
    name = C.invisible_rail_name,
    localised_name = { "entity-name.speedrail-invisible-rail" },
    icon = "__speedrail__/graphics/speed-limit-sign.png",
    icon_size = 64,
    hidden = true,
    hidden_in_factoriopedia = true,
    flags = {
      "placeable-neutral",
      "building-direction-8-way",
      "not-selectable-in-game",
      "not-blueprintable",
      "not-deconstructable",
      "not-on-map",
      "not-flammable",
      "not-repairable",
      "not-upgradable",
      "not-in-kill-statistics",
      "no-copy-paste",
    },
    -- "строительный" бокс (реальный бокс рельса зашит в движке)
    collision_box = { { -1, -1 }, { 1, 1 } },
    selection_box = { { -0.7, -0.8 }, { 0.7, 0.8 } },
    selectable_in_game = false,
    max_health = 100,

    -- ТОЛЬКО train-layer (+ слои тайлов, чтобы невидимый рельс не лёг на воду
    -- и на не-землю). Именно так ТЗ требует настроить коллизию.
    collision_mask = {
      layers = {
        train = true,
        ground_tile = true,
        water_tile = true,
        out_of_map = true,
      },
    },

    removes_soft_decoratives = false, -- не выжигать траву/камешки под собой
    -- pictures / fence_pictures / walking_sound намеренно НЕ заданы (optional)
  },

  -- --------------------------------------------------------------------------
  --  СЛЕДЫ ТОРМОЖЕНИЯ / ТРЕНИЯ (ТЗ 1.3, "визуализация").
  --
  --  ОТКЛОНЕНИЕ ОТ БУКВЫ ТЗ (согласовано в README, п. "Отклонения"):
  --  ТЗ требует `optimized-decorative` с `life_time = 1800`. В API 2.x у
  --  DecorativePrototype НЕТ поля life_time (https://lua-api.factorio.com/latest/prototypes/DecorativePrototype.html),
  --  а LuaSurface::create_decoratives/destroy_decoratives работают только
  --  "площадями" и не возвращают сущность — то есть 30-секундный авто-спавн/
  --  авто-распад без скриптового таймера недоступен.
  --
  --  Поэтому взят `corpse` (предок RailRemnantsPrototype — ровно тот класс,
  --  которым игра рисует обломки рельсов): у него есть нативное
  --  `time_before_removed` в тиках, он не выделяется, не добывается,
  --  не чертёжится и исчезает сам ровно через 1800 тиков.
  -- --------------------------------------------------------------------------
  {
    type = "corpse",
    name = C.skid_mark_name,
    localised_name = { "entity-name.speedrail-skid-mark" },
    icon = "__speedrail__/graphics/speed-limit-sign.png",
    icon_size = 64,
    hidden = true,
    hidden_in_factoriopedia = true,
    flags = { "placeable-neutral", "building-direction-8-way", "not-on-map" },
    collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
    collision_mask = { layers = {} },       -- ни с чем не сталкивается
    selection_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
    selectable_in_game = false,
    auto_setup_collision_box = false,
    expires = false,
    remove_on_tile_placement = false,
    remove_on_entity_placement = false,
    time_before_removed = 1800,             -- 30 секунд, как в ТЗ
    time_before_shading_off = 420,          -- последние ~7 секунд плавно гаснет
    final_render_layer = "decals",          -- рисуются как декаль по земле/бетону
    animation = {
      {
        filename = "__speedrail__/graphics/skid-mark.png",
        priority = "extra-high",
        width = 64,
        height = 64,
        direction_count = 8,                -- 8 повёрнутых копий в одном листе
        line_length = 1,
        scale = 1.0,
        tint = { r = 0.30, g = 0.28, b = 0.26, a = 0.80 },
      },
    },
  },
})

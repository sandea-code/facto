-- SpeedRail :: runtime-настройки (Mod Settings)
-- Все значения, которые ТЗ относит к "требует дополнительной проработки" (раздел 3),
-- вынесены сюда, чтобы их можно было tuning-овать без правки кода.

data:extend({

  -- ============================ РАЗДЕЛ 1.1 ==================================
  {
    type = "double-setting",
    name = "speedrail-max-limit-multiplier",
    setting_type = "runtime-global",
    default_value = 3.5,
    minimum_value = 1.0,
    maximum_value = 10.0,
    order = "a[limits]-a[max]",
  },
  {
    -- Ниже 1.0x уводить лимит нельзя намеренно: ТЗ, раздел 2, п.4 — ванильная
    -- скорость является базовой настройкой каждого блока.
    type = "int-setting",
    name = "speedrail-gui-slider-min-percent",
    setting_type = "runtime-global",
    default_value = 100,
    minimum_value = 25,
    maximum_value = 100,
    order = "a[limits]-b[slider-min]",
  },

  -- ============================ РАЗДЕЛ 1.2 ==================================
  {
    -- Ускорение на блоках с ПОВЫШЕННЫМ лимитом = 65% от ванильного (ТЗ 1.2).
    type = "double-setting",
    name = "speedrail-acceleration-factor",
    setting_type = "runtime-global",
    default_value = 0.65,
    minimum_value = 0.05,
    maximum_value = 1.0,
    order = "b[physics]-a[accel]",
  },
  {
    -- Насколько глубоко сканировать маршрут: ТЗ требует 2-3 блока вперёд.
    type = "int-setting",
    name = "speedrail-lookahead-blocks",
    setting_type = "runtime-global",
    default_value = 3,
    minimum_value = 1,
    maximum_value = 12,
    order = "b[physics]-b[lookahead]",
  },
  {
    -- Доля доступного замедления, при превышении которой начинается плавное
    -- упреждающее торможение (0.8 = тормозим, когда нужно 80% от возможного).
    type = "double-setting",
    name = "speedrail-brake-usage",
    setting_type = "runtime-global",
    default_value = 0.80,
    minimum_value = 0.30,
    maximum_value = 1.00,
    order = "b[physics]-c[brake-usage]",
  },
  {
    -- Период пересчёта маршрута/лимита для одного поезда (в тиках).
    type = "int-setting",
    name = "speedrail-scan-interval-ticks",
    setting_type = "runtime-global",
    default_value = 3,
    minimum_value = 1,
    maximum_value = 60,
    order = "b[physics]-d[scan]",
  },
  {
    -- Поезда медленнее этого значения не сканируются вообще (экономия UPS).
    type = "double-setting",
    name = "speedrail-min-scan-speed",
    setting_type = "runtime-global",
    default_value = 0.05,
    minimum_value = 0.0,
    maximum_value = 2.0,
    order = "b[physics]-e[min-speed]",
  },
  {
    -- Жёсткий предел длины одного скана маршрута (тайлов) — защита от
    -- гигантских бессигнальных сетей.
    type = "int-setting",
    name = "speedrail-max-scan-distance",
    setting_type = "runtime-global",
    default_value = 600,
    minimum_value = 50,
    maximum_value = 5000,
    order = "b[physics]-f[max-scan]",
  },

  -- ============================ РАЗДЕЛ 1.3 ==================================
  {
    -- Во сколько раз превышать лимит, чтобы сход считался состоявшимся.
    type = "double-setting",
    name = "speedrail-derail-tolerance",
    setting_type = "runtime-global",
    default_value = 1.05,
    minimum_value = 1.00,
    maximum_value = 2.00,
    order = "c[derail]-a[tolerance]",
  },
  {
    type = "double-setting",
    name = "speedrail-curve-speed-tight",
    setting_type = "runtime-global",
    default_value = 0.55,
    minimum_value = 0.05,
    maximum_value = 1.00,
    order = "c[derail]-b[tight]",
  },
  {
    type = "double-setting",
    name = "speedrail-curve-speed-wide",
    setting_type = "runtime-global",
    default_value = 0.70,
    minimum_value = 0.05,
    maximum_value = 1.00,
    order = "c[derail]-c[wide]",
  },
  {
    type = "double-setting",
    name = "speedrail-curve-speed-half",
    setting_type = "runtime-global",
    default_value = 0.90,
    minimum_value = 0.05,
    maximum_value = 1.00,
    order = "c[derail]-d[half]",
  },
  {
    type = "double-setting",
    name = "speedrail-curve-speed-ramp",
    setting_type = "runtime-global",
    default_value = 0.60,
    minimum_value = 0.05,
    maximum_value = 1.00,
    order = "c[derail]-e[ramp]",
  },
  {
    -- Множитель силы торможения на время инерционного пробега (ТЗ 1.3: x3).
    type = "double-setting",
    name = "speedrail-derail-braking-multiplier",
    setting_type = "runtime-global",
    default_value = 3.0,
    minimum_value = 1.0,
    maximum_value = 20.0,
    order = "c[derail]-f[braking]",
  },
  {
    -- ТЗ, раздел 3 (UPS): не более 100-150 сегментов невидимых рельсов.
    type = "int-setting",
    name = "speedrail-max-invisible-segments",
    setting_type = "runtime-global",
    default_value = 150,
    minimum_value = 10,
    maximum_value = 150,
    order = "c[derail]-g[segments]",
  },
  {
    type = "int-setting",
    name = "speedrail-max-skid-marks",
    setting_type = "runtime-global",
    default_value = 48,
    minimum_value = 0,
    maximum_value = 400,
    order = "c[derail]-h[marks]",
  },
  {
    -- 1800 тиков = 30 секунд (ТЗ 1.3, life_time декораций).
    type = "int-setting",
    name = "speedrail-skid-mark-lifetime",
    setting_type = "runtime-global",
    default_value = 1800,
    minimum_value = 60,
    maximum_value = 108000,
    order = "c[derail]-i[lifetime]",
  },
  {
    -- Урон вагонам после полной остановки (ТЗ 1.3: "-50 HP").
    type = "int-setting",
    name = "speedrail-derail-damage",
    setting_type = "runtime-global",
    default_value = 50,
    minimum_value = 0,
    maximum_value = 5000,
    order = "c[derail]-j[damage]",
  },
  {
    -- Доля груза, которая высыпается из каждого вагона (spill_cargo).
    type = "double-setting",
    name = "speedrail-spill-ratio",
    setting_type = "runtime-global",
    default_value = 0.25,
    minimum_value = 0.0,
    maximum_value = 1.0,
    order = "c[derail]-k[spill]",
  },
  {
    -- Аварийный таймаут инерционного пробега (тиков). Срабатывает только если
    -- поезд по какой-то причине не может остановиться сам.
    type = "int-setting",
    name = "speedrail-derail-max-ticks",
    setting_type = "runtime-global",
    default_value = 1800,
    minimum_value = 120,
    maximum_value = 10800,
    order = "c[derail]-l[timeout]",
  },
  {
    -- Возвращать ли игроку рельсы, уничтоженные скриптом в точке схода.
    -- По умолчанию ВЫКЛ (строгий штраф), см. README, раздел "Эксплойты".
    type = "bool-setting",
    name = "speedrail-restore-removed-rails",
    setting_type = "runtime-global",
    default_value = false,
    order = "c[derail]-m[restore]",
  },

  -- ============================ ПРОЧЕЕ ======================================
  {
    -- Запас хода торможения: насколько поезд длиннее своей "носовой" точки —
    -- расстояние до поворота считается до ПОСЛЕДНЕГО вагона.
    type = "bool-setting",
    name = "speedrail-account-train-length",
    setting_type = "runtime-global",
    default_value = true,
    order = "d[misc]-a[length]",
  },
  {
    type = "bool-setting",
    name = "speedrail-debug-draw",
    setting_type = "runtime-global",
    default_value = false,
    order = "d[misc]-b[debug]",
  },
  {
    -- Печатать в чат сообщения о сходе/повреждениях.
    type = "bool-setting",
    name = "speedrail-log-to-console",
    setting_type = "runtime-global",
    default_value = true,
    order = "d[misc]-c[log]",
  },
})

# ISI Unlocked Traders

A 7 Days to Die (7D2D) mod that allows traders to spawn in any biome. It also changes the way players progress from trader to trader and biome to biome to account for that random spawning.

## Unlocked Traders

Allows any trader to spawn in any biome. Because 7D2D relies on RNG it is possible for some biomes to have many traders while others have none. Some settings have been tweaked to help avoid that, but it is still a possibility.

When you create a map make sure at least one trader spawns in each biome. Traders are shown as red squares, and are often located on the edge of cities near major roads.

Or you can hit `F1` and look for lines that look like this: `Trader trader_jen, desert, gateway, marker , at 7235, 5139`

## Progression Options

Allowing traders to spawn in any biome required changes to the "Journey to Settlement" and "Opening Trade Routes" quests because they were bound to specific biomes or specific traders and RNG does not play nice with those requirements.

Thera are four options:

- Vanilla - Pine to Wasteland, Rekt to Joel
  - _this is the same as the base game, it is only included for completeness_
- Random Traders - Pine to Wasteland, Any trader (default, recommended)
- Random Biomes - Any biome, Rekt to Joel
- All Random - Any biome, Any trader

You can change this setting in `\ISI_UnlockedTraders\Config\quests.xml`.

## Troubleshooting

### "Journey to Settlement" quest says "NO TRADER"

RNG did not spawn the appropriate trader in the Pine Forest.

- Keep going. You can still complete the quest, but you will have to manually find a trader.
- Restart. Create a new map and make sure the appropriate trader spawns in the Pine Forest.
- Switch to `Random Biomes` or `All Random`

### Trader did not offer the next "Opening Trade Routes" quest

RNG did not spawn the expected trader in the next biome.

- Wait a day. Sometimes the quest doesn't show up until the next day.
- Vist the other traders. They may send you to the expected trader but in a different biome than expected.
- Manually find the next trader (they won't be in the expected biome).
- Skip it. Not ideal, but you can keep working towards the next tier without going to the next trader.
- Restart. Create a new map and verify the appropriate trader spawns in each biome.
- Switch to `Random Biomes` or `All Random`

### There are too many traders in one biome

- Go to `\ISI_UnlockedTraders\Prefabs\POIs\trader_bob.xml` and increase `ThemeRepeatDistance` for each trader, then generate a new map. Repeat until traders are more evenly spaced.

### Traders are not spawning in every biome

- Go to `\ISI_UnlockedTraders\Config\rwgmixer.xml` and increase `min_count` and `max_count` then generate a new map. Repeat until a trader shows up in every biome.

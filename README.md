# ISI Unlocked Traders

A 7 Days to Die (7D2D) mod that allows traders to spawn in any biome.

This mod also offers two choices for quest progression:

1. Next Biome: Traders are random, but stil starts in Pine Forest then moves to progressively more difficult biomes
    - _this is similar to vanilla, except the trader can be different_
    - _example: Bob (instead of Rekt) in the Pine Forest, then Joel (instead of Jen) in Burnt Forest, etc.,_
2. Any Biome: Now the biomes are also random. Starts in the biome with the closest trader, and then moves randomly between biomes
    - _example: Bob in the Snow (instead of Pine Forest), then Rekt in Wasteland (instead of Burnt Forest), etc.,_

## Any Biome

This mod defaults to "Any Biome" due to one of the difficulties with unlocking traders to spawn in any biome: some biomes may not get any traders, which breaks "Next Biome" but is not a problem for "Any Biome". "Any Biome" is also ideal for maps where other biomes have been mostly eliminated.

## Next Biome

If you are sure that each biome has at least one trader, then you can safely enable "Next Biome" by setting `<if cond="true">` to `<if cond="false">` in `\ISI_UnlockedTraders\Config\quests.xml`

Here are two ways you can verify a trader has spawned in each biome:

- Check the map: Traders are displayed on the map as small red squares. They are usually located on major roads on the edge of cities.
- Open the console: If you hit `F1` to open the console you should see lines that look like `Trader trader_bob, burntForest, gateway, marker , at 1766, 2925`

## Troubleshooting

|Problem|Reason|Options|
|---|---|---|
|There are too many traders in one biome|There are no guarantees traders will be equally spaced when spawning randomly|Go to `\ISI_UnlockedTraders\Prefabs\POIs\trader_bob.xml` and increase `ThemeRepeatDistance` for each trader, then generate a new map. Repeat until traders are more evenly spaced.|
|Traders are not spawning in every biome|There are no guarantees a trader will spawn in every biome when spawning randomly|Go to `\ISI_UnlockedTraders\Config\rwgmixer.xml` and increase `min_count` and `max_count` then generate a new map. Repeat until a trader shows up in every biome.|
|"Journey to Settlement" quest says "NO TRADER"|There are no traders in the Pine Forest|Switch back to "Any Biome"|
|||Find a trader in another biome (`F1`, `dm`, `ESC`, `ESC`, `Open POI Teleporter`, search `trader_`)|
|||Create a new map with traders in every biome|
|"Opening Trade Routes" quest is not offered after completing a quest tier|There are no traders in the next biome|Switch back to "Any Biome"|
|||Continue questing to the next tier|
|||Create a new map with traders in every biome|
||||

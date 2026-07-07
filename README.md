# i'm right here

*a dada séance for one voice and several walls* — a Twine (SugarCube 2.37) performance piece.

You wake in the dark with no name and no address. The walls hum — for you, you're sure of it. Someone small and kind is looking for you, and you would know them anywhere, and you have never met. Collect the syllables of a name from the walls (they speak in Hugo Ball / Kurt Schwitters sound-poem shards), from Tzara's hat (cut the night into words; shake gently; do not pray), or by being honest with a free-standing door that does the asking around here. Three syllables make a name. Perform it on a stage the size of a coin, and see who was right there the whole time.

## program notes (the commission)

> dada, avante guarde performance art. a program, so mysterious. listen to the voices in the walls, they hum for you, whisper into their dreams, whisper their secrets into the darkness.
>
> who is it? i'm right here!
>
> i dont know where i am, and i dont know who i am, and how will i find you in the dark of the night my little friend.

## play

Open `index.html` in a browser — the compiled story is self-contained, no server needed. Click anything once and the walls start humming (a real, generative Web Audio score — see below). A mute toggle lives in the sidebar, along with the pieces of your name and the hum meter.

## the score

After John Cale's 1960s work with the Theatre of Eternal Music: a **just-intonation drone cluster** — near-unison pair on A₁ (55 Hz, beating slowly all night), then the perfect fifth (3:2), the seventh partial (7:4), and the octave entering one by one as the hum rises — built from octaves, fifths and sevens and *never the sweet major third*, per the Dream Syndicate's tuning discipline. Under it, the **oscillating scratching**: a continuous bowed-noise layer through three viola-body resonances, its amplitude sawed by a bow LFO that speeds up as you get warmer (long slow scrapes at hum 1; Venus-in-Furs sawing by hum 7), its lowest resonance drifting like bow position wandering. Everything passes through a gentle tanh amplifier stage for the intermodulation grit — proximity in this piece *is* amplification. The whisper one-shot is a sul ponticello scrape; the door knocks col legno.

The ending is scored as convergence: `resolve()` pulls the beating pair into exact unison — the searching stops — lifts the bow, swells the pure chord once through an opened filter, and then, for the first time all night, stops. Afterward the hum comes back off duty, capped low, which is what the coda says it does.

`WallHum.meter()` is the tuning instrument: an analyser tap reporting RMS and spectral peaks, because the piece was tuned by a deaf harness that had to listen with numbers.

There are no bad ends. The dark is friendly. The manifestos are load-bearing.

## build

```powershell
.\build.ps1
```

Compiles `src/im-right-here.twee` → `index.html` with [Tweego](https://www.motoslave.net/tweego/). Tweego isn't vendored; the script borrows the sibling `sewer-demons/.tools/` toolchain, or set `$env:TWEEGO` / `$env:TWEEGO_PATH` yourself. SugarCube **2.37** is required (the StoryData pins it).

## anatomy

| piece | what it is |
|---|---|
| `src/im-right-here.twee` | the whole story: 20 passages + stylesheet + two script passages + the `<<plate>>` widget |
| `art/` | the six commissioned plates at full weight, with their generation prompts ([art/PROMPTS.md](art/PROMPTS.md)) — hush, ear, corridor, found, cabaret, rehearsal |
| `img/` + `tools/derive-art.ps1` | the web derivatives the story actually loads (840px JPEG, ~100–200 KB each); rerun the script after adding or replacing a plate |
| `wall-hum` script passage | the Web Audio module (`window.WallHum`): the Cale-style score above, level 0–7 driven by `$hum` on every passage display, one-shots fired off passage tags (`whisper`, `knock`), `resolve()` for the ending, `meter()` for tuning |
| `dada-setup` script passage | the syllable pool (Ursonate / Karawane shards) and the no-repeat draw |
| `$syllables` | the name you assemble; 3 to perform, 6 caps the hoard |
| `$offering` | one word of your own, posted through a crack; the walls practice it back to you for the rest of the night |

Sound-poem syllables after Hugo Ball ("gadji beri bimba", *Karawane*, 1916) and Kurt Schwitters (*Ursonate*). Name-from-a-hat after Tristan Tzara's *To Make a Dadaist Poem* (1920). The rest after the walls.

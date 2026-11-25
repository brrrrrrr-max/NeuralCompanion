# Neural Companion

**An AI companion for BONELAB that talks, listens, fights, drives and thinks - all running on your own PC.**

Spawn it, talk to it like a person, and it does what you ask: follows you, fights beside you, hands you a gun, drives you somewhere - or turns on you in Hostile mode and hunts you down, trash-talking the whole way.

Two parts, both from the [latest release](https://github.com/brrrrrrr-max/NeuralCompanion/releases/latest):

- **The mod** - `NeuralCompanion-NeuralCompanion-<version>.zip` (5 MB)
- **The runtime** - its AI, voice and ears (about 6 GB), installed by `Install.Neural.Companion.runtime.cmd`

## Install (once)

**1. The runtime**

1. Download **`Install.Neural.Companion.runtime.cmd`** from the [latest release](https://github.com/brrrrrrr-max/NeuralCompanion/releases/latest) and double-click it. (Windows may say it protected your PC - click **More info > Run anyway**.)
2. Wait for **DONE**. It downloads about 6 GB (it carries on where it stopped if your internet drops), checks it isn't damaged (SHA-256) and installs it in `%LOCALAPPDATA%\NeuralCompanion\Runtime`. It needs about 16 GB free while it installs, 8 GB after.

**2. The mod**

- **With r2modman (easiest):** make a BONELAB profile, add **BoneLib** to it from the Online tab, then **Settings > Import local mod** and pick the `NeuralCompanion-NeuralCompanion-<version>.zip` you downloaded. Start BONELAB with **Start modded** (the first start of a new profile takes a few minutes while MelonLoader sets itself up).
- **Without a mod manager:** install [MelonLoader](https://github.com/LavaGang/MelonLoader/releases) 0.7 into BONELAB and put [BoneLib](https://thunderstore.io/c/bonelab/p/bonelib/BoneLib/) in its `Mods` folder, then unzip the mod zip's `Mods` and `UserData` folders into your BONELAB folder.

**3. Play**

In BoneMenu: **Neural Companion > Spawn the bot**, then **Start the brain**. About 15 seconds later, say its name and talk to it.

## Needs

- BONELAB on PC VR (Windows 10/11, 64-bit) and a microphone (your Windows default one)
- A decent graphics card - the AI shares it with the game. Tested on a 16 GB AMD card; on a smaller card use **Fast** mode

## Removing it

Remove the mod in r2modman (or delete `Mods\NeuralCompanion.dll` and `UserData\NeuralCompanion` from your BONELAB folder), then delete `%LOCALAPPDATA%\NeuralCompanion` (the runtime, its settings and what it learned).

## What's in the runtime

All official, unmodified builds, each under its own licence (full texts in the runtime's `LICENSES` folder):

- **Python 3.12.10** (python.org's Windows build) with numpy, sherpa-onnx, sounddevice, cffi, pycparser, ptts
- **Ollama 0.40.16** (MIT) with its NVIDIA, AMD and CPU libraries - started by the game on its own port (11435), reachable only from your PC
- **Qwen3 1.7B** (Apache 2.0), 4-bit and 8-bit
- **NVIDIA Parakeet TDT 0.6B v2** (CC BY 4.0), **Silero VAD** (MIT), **Phonon 31M** "Preston" (Apache 2.0), **Supertonic 3** (OpenRAIL-M - its use restrictions apply to you too)

Nothing is sent anywhere: the AI, voice and speech recognition all run on your PC.

## Found a bug?

Open a [new issue](https://github.com/brrrrrrr-max/NeuralCompanion/issues/new/choose): say what went wrong and how to make it happen again, and drag in your bug report file (in game: **Settings > Brain and voice > Bug report > Make a bug report file** - it goes on your Desktop, your Windows name taken out). Issues are public, so don't put anything personal in them.

## Licence

The mod, its brain, the installer script and this page: MIT. This mod's code was written with an AI coding assistant (Claude), directed and tested in VR by its author.

# Neural Companion - runtime

**Neural Companion** is an AI companion mod for BONELAB that talks, listens, fights and drives - all running on your own PC. The mod itself is on Thunderstore; this page has the part that couldn't go there: **the runtime** (its AI, voice and ears, about 6 GB to download).

## Install the runtime (once)

1. Download **`Install.Neural.Companion.runtime.cmd`** from the [latest release](https://github.com/brrrrrrr-max/NeuralCompanion/releases/latest).
2. Double-click it. (Windows may say it protected your PC - click **More info > Run anyway**.)
3. It downloads the runtime from this page (about 6 GB - it carries on where it stopped if your internet drops), checks it isn't damaged (SHA-256), and installs it in `%LOCALAPPDATA%\NeuralCompanion\Runtime`. It needs about 16 GB free while it installs, 8 GB after.
4. Install **NeuralCompanion** on Thunderstore with your mod manager, start BONELAB, then BoneMenu > **Neural Companion > Spawn the bot**, then **Start the brain**.

To remove it: delete `%LOCALAPPDATA%\NeuralCompanion\Runtime`.

## What's in it

All official, unmodified builds, each under its own licence (full texts in the runtime's `LICENSES` folder):

- **Python 3.12.10** (python.org's Windows build) with numpy, sherpa-onnx, sounddevice, cffi, pycparser, ptts
- **Ollama 0.40.16** (MIT) with its NVIDIA, AMD and CPU libraries - started by the game on its own port (11435), reachable only from your PC
- **Qwen3 1.7B** (Apache 2.0), 4-bit and 8-bit
- **NVIDIA Parakeet TDT 0.6B v2** (CC BY 4.0), **Silero VAD** (MIT), **Phonon 31M** "Preston" (Apache 2.0), **Supertonic 3** (OpenRAIL-M - its use restrictions apply to you too)

Nothing is sent anywhere: the AI, voice and speech recognition all run on your PC.

## Found a bug?

Use the [bug report form](https://docs.google.com/forms/d/e/1FAIpQLScRi6wIUh8Z2tA0rjOTqGkoOzKBNLqWuTwX8HVdusWSCs0Evw/viewform) - it's anonymous.

The installer script and this page: MIT licence.

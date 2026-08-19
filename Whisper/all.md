```sh
sudo apt install cmake
# Ещё нужны gcc/g++/make

# https://github.com/ggml-org/whisper.cpp
git clone https://github.com/ggml-org/whisper.cpp.git
cd whisper.cpp
sh ./models/download-ggml-model.sh small
sh ./models/download-ggml-model.sh large-v3-turbo
# For use: ./build/bin/whisper-cli -m /home/iadfeshchm/whisper.cpp/models/ggml-small.bin -f samples/jfk.wav
cmake -B build
cmake --build build -j --config Release

test -x ~/whisper.cpp/build/bin/whisper-cli && echo OK
~/whisper.cpp/build/bin/whisper-cli -m /home/iadfeshchm/whisper.cpp/models/ggml-small.bin -f /tmp/debash-voice-1787070045773.wav -otxt -l ru
```

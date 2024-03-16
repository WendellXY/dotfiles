curl -O -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip
mkdir tmp
mv FontPatcher.zip tmp/
unzip tmp/FontPatcher.zip -d tmp/
cd tmp
mkdir results
for file in $1/*; do
    fontforge -script font-patcher $file -c --out results/
done

cd ..
mv tmp/results results
rm -rf tmp

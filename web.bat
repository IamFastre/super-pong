@echo off

echo "<<--START-->>"
cd ./build/Web

git add .
git commit -m %1
git push

cd ../..
echo "<<--END-->>"

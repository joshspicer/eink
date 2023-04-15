- https://github.com/SolderedElectronics/Inkplate-Arduino-library

```bash
cd build/
docker build . -t eink-today

docker run --rm -v /workspaces/eink/:/output  eink-today
```
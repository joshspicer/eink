- https://github.com/SolderedElectronics/Inkplate-Arduino-library

```bash
docker build ./build -t eink-today

docker run --rm -v /workspaces/eink/:/output  eink-today
```
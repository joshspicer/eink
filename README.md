- https://github.com/SolderedElectronics/Inkplate-Arduino-library

```bash
docker build ./newspaper_article_builder -t eink-today

docker run --rm -v /workspaces/eink/:/output  eink-today
```
# eink

## Server

```bash
$ docker build ./server -t eink

$ docker run --rm eink

Starting...
Server listening on port 3000!

$ curl localhost:3000/update

$ wget localhost:3000/newspaper.bmp
```

## Client sketch

> See _https://github.com/SolderedElectronics/Inkplate-Arduino-library_

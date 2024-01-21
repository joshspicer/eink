#!/bin/bash

 curl -X PATCH \
    -d '{ \
      \"url\": \"https://joshspicer.com/assets/me/7.jpg\" \
      }' \
    http://localhost:3000/update?mode=web
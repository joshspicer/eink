#!/bin/bash

 curl -X PATCH \
    -d '{ \
      \"header1\": \"Header 1\", \
      \"header2\": \"Header 2\", \
      \"header3\": \"Header 3\", \
      \"data1\": \"Hello this is some content within the first data section\", \
      \"data2\": \"Hello this is some content within the second data section\", \
      \"data3\": \"Hello this is some content within the third data section\" \
      }' \
    http://localhost:3000/update?mode=newspaper
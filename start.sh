#!/bin/bash
aria2c --conf-path=/aria2/aria2.conf &
nginx -g 'daemon off;'

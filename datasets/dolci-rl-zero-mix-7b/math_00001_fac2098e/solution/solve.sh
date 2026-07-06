#!/bin/bash
# Oracle: emit the reference solution shipped with the dataset.
set -e
mkdir -p /app
echo NA== | base64 -d > /app/answer.txt

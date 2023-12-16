#!/usr/bin/env bash
# upgrades all pip packages
# author: Harshvardhan J. Pandit
pip install --upgrade $(pip list -ol | tail -n +3 | awk '{print }')

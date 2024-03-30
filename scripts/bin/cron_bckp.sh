#!/bin/bash

cd $HOME/Nextcloud
tar -czLf "$HOME/backups/bckp_org_`date +%d%H`.tar.gz" org bank/password-store.kdbx


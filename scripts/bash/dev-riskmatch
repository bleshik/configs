#!/bin/bash - 
cd ~/K/risk
tmux new-session -d -s 'dev_riskmatch' -n 'master-site' -c 'master-site' \;\
     new-window -n 'master-worker' -c 'master-worker' \;\
     new-window -n 'broker-site' -c 'broker-site' \;\
     new-window -n 'broker-worker' -c 'broker-worker' \;\
     new-window \;\
     send-keys -t dev_riskmatch:4 'mysql -u root' C-m \;\
     attach

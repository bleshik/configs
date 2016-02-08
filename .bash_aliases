alias f='find . -name '
alias grailsDebug='grails -reloading -Dcache=false'
alias grailsWatch='grails test-app unit: ; while true ; do echo "---" && fswatch -i .*.java -i .*.groovy -o -1 -0 . | xargs -0 -n1 -I{} grails test-app -rerun unit: ; done'
alias gradleDebug='gradle-debug'
alias sbtDebug='sbt-debug'

alias showDotFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideDotFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias mysqlStart='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist'
alias mysqlStop='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist'
alias mysqlStartUpSetUp='ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents'
alias postgresStart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias postgresStop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias mysql="altsql"

alias toDate='date -r'

alias stop_api="fleetctl destroy bills-api@1.service bills-api-update@1.service bills-api-update@1.timer"
alias start_api="(cd ~/K/bills/coreos/; fleetctl start bills-api@1.service bills-api-update@1.service bills-api-update@1.timer)"
alias restart_api="stop_api && start_api"

alias stop_web-app="fleetctl destroy bills-web-app@1.service bills-web-app-update@1.service bills-web-app-update@1.timer"
alias start_web-app="(cd ~/K/bills/coreos/; fleetctl start bills-web-app@1.service bills-web-app-update@1.service bills-web-app-update@1.timer)"
alias restart_web-app="stop_api && start_api"

alias flw="fleetctl --tunnel where00 --ssh-timeout=10"

source ~/.bash_rm_aliases

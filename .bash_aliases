alias f='find . -name '
alias grailsDebug='grails-debug -reloading'
alias gradleDebug='gradle-debug'
alias dbdiff='grails dbm-gorm-diff'
#alias grails='grails -reloading'
#alias groovy='groovy -reloading'
alias showDotFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideDotFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias mysqlStart='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist'
alias mysqlStop='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist'
alias mysqlStartUpSetUp='ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents'

alias stop_api="fleetctl destroy bills-api@1.service bills-api-update@1.service bills-api-update@1.timer"
alias start_api="(cd ~/K/bills/coreos/; fleetctl start bills-api@1.service bills-api-update@1.service bills-api-update@1.timer)"
alias restart_api="stop_api && start_api"

alias stop_web-app="fleetctl destroy bills-web-app@1.service bills-web-app-update@1.service bills-web-app-update@1.timer"
alias start_web-app="(cd ~/K/bills/coreos/; fleetctl start bills-web-app@1.service bills-web-app-update@1.service bills-web-app-update@1.timer)"
alias restart_web-app="stop_api && start_api"

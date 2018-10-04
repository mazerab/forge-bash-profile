#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases.
#                Much of this was originally copied from:
#                http://natelandau.com/my-mac-osx-bash_profile/
#
#  Sections:
#  1.   Environment Configuration
#  2.   Make Terminal Better (remapping defaults and adding functionality)
#  3.   File and Folder Management
#  4.   Searching
#  5.   Process Management
#  6.   Networking
#  7.   System Operations & Information
#  8.   Web Development
#  9.   Forge Platform
#
#  ---------------------------------------------------------------------------
 
#   ---------------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   ---------------------------------------

#   Set default blocksize for ls, df, du
#   ---------------------------------------
    export BLOCKSIZE=1k

#   Set Amazon 
#   ---------------------------------------
    export AWS_PROFILE=claudia

#   Set Slack
#   ---------------------------------------
    export SLACK_BOT_TOKEN='xoxb-104329440215-2Tp0poSqsVwzHMQU738Aetdq'
    export SLACK_BOT_ID='U329PCY6B'
    export SLACK_MACHINE=10.41.89.143

#   ---------------------------------------
#   2.  MAKE TERMINAL BETTER
#   ---------------------------------------

alias ls='ls -Gp'			    # Preferred ‘ls’ implementation
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
 
#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
 
#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }
 
#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#   ---------------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   ---------------------------------------

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir

#   ---------------------------------------
#   4.  SEARCHING
#   ---------------------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string
 
#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

#   ---------------------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }
 
#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
 
#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
 
#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'
 
#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"
 
#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }

#   ---------------------------------------
#   6.  NETWORKING
#   ---------------------------------------

alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs
 
#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }

#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
 
#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#   ---------------------------------------
#   8.  WEB DEVELOPMENT
#   ---------------------------------------

alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
alias json='cat $1 | python -m json.tool'               # json:             Takes a JSON string and formats it using Python's json.tool
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page
#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

export PROJECT_HOME=$HOME/source/repos

#   ---------------------------------------
#   9.  FORGE PLATFORM
#   ---------------------------------------

#   setForgeDemoApp: Declare the demo app environment
#   Available demo apps:
#   catalog, dwg2pdf, dwg2xls, interactive_instructions, recap_mobile,
#   tokenflex_dashboard, tokenflex_tutorial, virtual_ops
#   -------------------------------------------------------------------
    declare -a forgeDemoApps=( "catalog" "dwg2pdf" "dwg2xls"
                               "interactive_instructions" "recap_mobile" "tokenflex_dashboard"
                               "tokenflex_tutorial" "virtual_ops" )
    getForgeAppSecretValue () {
        aws secretsmanager get-secret-value --secret-id $@
    }
    listForgeApps () {
        for app in ${!forgeDemoApps[@]};
        do 
            echo "${forgeDemoApps[$app]}"
        done 
    }
    setForgeDemoAppEnv () { 
        echo "Please type the number of the app you want to set the environment for: "
        for app in ${!forgeDemoApps[@]};
        do
            echo "[$app] - ${forgeDemoApps[$app]}"
        done
        read answer
        local app_name='undefined'
        local callback_url='http://localhost:3000/api/forge/callback/oauth'
        case "$answer" in
            0 )
                app_name='catalog' ;;
            1 )
                app_name='dwg2pdf' ;;
            2 )
                app_name='dwg2xls' ;;
            3 )
                app_name='interactive_instructions' ;;
            4 )
                app_name='recap_mobile' ;;
            5 )
                #export HEROKU_VUE_HOST=http://localhost:8080
                #export HEROKU_KOA_HOST=http://localhost:5000
                app_name='tokenflex_dashboard'
                callback_url='http://localhost:5000/api/oauth/callback' ;;
            6 )
                app_name='tokenflex_tutorial' ;;
            7 )
                app_name='virtual_ops' ;;
        esac
        echo -e "Setting environment for Forge demo app: $app_name";
        secret_json=$(getForgeAppSecretValue $app_name)
        secret_string=$(echo $secret_json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["SecretString"]')
        client_id=$(echo $secret_string | python -c 'import json,sys;obj=json.load(sys.stdin);print obj.keys()[0]')
        client_secret=$(echo $secret_string | python -c 'import json,sys;obj=json.load(sys.stdin);print obj.values()[0]')
        export FORGE_CLIENT_ID=$client_id
        export FORGE_CLIENT_SECRET=$client_secret
        export FORGE_CALLBACK_URL=$callback_url
        echo "FORGE_CLIENT_ID=$FORGE_CLIENT_ID"
        echo "FORGE_CLIENT_SECRET=$FORGE_CLIENT_SECRET"
        echo "FORGE_CALLBACK_URL=$FORGE_CALLBACK_URL"
    }

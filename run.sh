# Put defaults here
export HUBOT_IRC_SERVER="irc.freenode.net"
export HUBOT_IRC_ROOMS="#southackton,#somakeit,#smibtest"
export HUBOT_IRC_NICK="yoshibot"
export HUBOT_IRC_UNFLOOD="true"
export HUBOT_ANNOUNCE_ROOMS="$HUBOT_IRC_ROOMS"
export PORT=5555
export HUBOT_URL="http://members.somakeit.org.uk:$PORT/"
# Local 'env' file overrides these and adds more
. ./env
bin/hubot -a irc2 -n $HUBOT_IRC_NICK --alias '!'

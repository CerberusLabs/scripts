bind pub - !whois doWhois
bind pub n !rehash doRehash

proc doWhois {nick uhost hand chan arg} {
        set theNick $nick
        if { [llength $arg] == 1 } {
                set theNick [lindex [split $arg] 0]
        }
        if { [validuser [nick2hand $theNick]] == 1 } {
                set whoishand [nick2hand $theNick]
                putquick "PRIVMSG $chan :I know $theNick as $whoishand"
                putlog "$theNick (on $chan) has flags: [chattr [nick2hand $theNick] $chan]"
        } else {
                putquick "PRIVMSG $chan :I do not recognize $theNick"
        }
}

proc doRehash {nick host hand chan args} {
        global botnick
        if {[llength [join $args]] > 0} {
                if {[string compare -nocase [lindex [join $args] 0] $botnick]} {
                        return
                }
        }
        rehash
        putquick "PRIVMSG $chan :\[$botnick ok\]"
}

bind pub - !uptime doUptime
bind pub - !botup doBotUp

#setudef flag do_uptime

proc doUptime {nick uhost hand chan arg} {
# Comment this out if you want it to work on a global concept
if {![channel get $chan "do_uptime"]} { return }

  global botnick
  if {[llength [join $arg]] > 0} {
    if {[string compare -nocase [lindex [join $arg] 0] $botnick]} {
      return
    }
  }

  catch {exec uptime} uptime

  catch {exec hostname} hostname
  set hostname [string tolower $hostname]

  catch {exec lsb_release -ds} distro
  set distro [string trim $distro "\""]

  set osver [lindex [unames] 0]
  putquick "PRIVMSG $chan :Uptime for $hostname ($distro): $uptime"
}

proc doBotUp {nick uhost hand chan arg} {
# Comment this out if you want it to work on a global concept
if {![channel get $chan "do_uptime"]} { return }

  global botnick
  if {[llength [join $arg]] > 0} {
    if {[string compare -nocase [lindex [join $arg] 0] $botnick]} {
      return
    }
  }

  global uptime
  global server-online

  set myuptime [duration [expr [clock seconds] - $uptime]]
  set myonline [duration [expr [clock seconds] - ${server-online}]]

  putquick "PRIVMSG $chan :I have been running for $myuptime"
  putquick "PRIVMSG $chan :I have been connected for $myonline"
}

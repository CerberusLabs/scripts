# Simple Memory Usage Script for Eggdrop
# Created by Andromeda

bind pub - !mem doMemory

proc doMemory {nick uhost hand chan arg} {
  global botnick
  if {[llength [join $arg]] > 0} {
    if {[string compare -nocase [lindex [join $arg] 0] $botnick]} {
      return
    }
  }

  catch {exec cat /proc/meminfo | grep MemTotal} MemTotal
  catch {exec cat /proc/meminfo | grep MemAvailable} MemAvailable

  set MemTotal [string trim $MemTotal "MemTotal:"]
  set MemAvailable [string trim $MemAvailable "MemAvailable:"]

  set MemTotal [string trim $MemTotal "kB"]
  set MemAvailable [string trim $MemAvailable "kB"]

  set MemTotal [string trim $MemTotal " "]
  set MemAvailable [string trim $MemAvailable " "]

  set MemUsed [expr {$MemTotal - $MemAvailable}]

  set MemTotal [expr {$MemTotal / 1024. / 1024.}]
  set MemTotal [expr {double(round(100*$MemTotal))/100}]

  set MemAvailable [expr {$MemAvailable / 1024. / 1024.}]
  set MemAvailable [expr {double(round(100*$MemAvailable))/100}]

  set MemUsed [expr {$MemUsed / 1024. /1024.}]
  set MemUsed [expr {double(round(100*$MemUsed))/100}]

  putquick "PRIVMSG $chan :\[System Memory\] Total: $MemTotal GB / Available: $MemAvailable GB / Used: $MemUsed GB"
}

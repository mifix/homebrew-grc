require 'formula'

class Grc < Formula
  homepage 'https://github.com/pengwynn/grc'
  url 'https://github.com/pengwynn/grc/tarball/master'
  md5 '3b512f31675771eb961251f632452288'
  version '1.4'

  def install
    #TODO we should deprefixify since it's python and thus possible
    inreplace ['grc', 'grc.1'], '/etc', etc
    inreplace ['grcat', 'grcat.1'], '/usr/local', prefix

    etc.install 'grc.conf'
    bin.install %w[grc grcat]
    (share+'grc').install Dir['conf.*']
    man1.install %w[grc.1 grcat.1]

    (prefix+'etc/grc.bashrc').write rc_script
  end

  def rc_script; <<-EOS.undent
    GRC=`which grc`
    if [ "$TERM" != dumb ] && [ -n GRC ]
    then
        alias colourify="$GRC -es --colour=auto"
        alias configure='colourify ./configure'
        alias diff='colourify diff'
        alias make='colourify make'
        alias gcc='colourify gcc'
        alias g++='colourify g++'
        alias as='colourify as'
        alias gas='colourify gas'
        alias ld='colourify ld'
        alias netstat='colourify netstat'
        alias ping='colourify ping'
        alias traceroute='colourify /usr/sbin/traceroute'
    fi
    EOS
  end

  def caveats; <<-EOS.undent
    New shell sessions will start using GRC after you add this to your profile:
      source "`brew --prefix`/etc/grc.bashrc"
    EOS
  end
end

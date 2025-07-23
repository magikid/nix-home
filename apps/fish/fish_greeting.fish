function fish_greeting
  if test -d ~/.local/habits/
    fortune ~/.local/habits | lolcat --force | boxes --design unicornsay
  else
    fortune | lolcat --force | boxes --design unicornsay
  end
end

Linda Delta Lamp
================
turn on/off the Lamp in DeltaS112 with RocketIO::Linda and Relay on Arduino

* https://github.com/masuilab/linda-delta-lamp
* watch tuple ["lamp", "on"] and turn on the lamp
* watch tuple ["lamp", "off"] and turn off the lamp
* then write tuple ["lamp", "on", "success"]

<img src="http://gyazo.com/173d1296cb3661bd0c830315784d6bd6.gif">


Dependencies
------------
- [Arduino Firmata](https://github.com/shokai/arduino_firmata)
- Ruby 1.8.7 ~ 2.0.0
- [LindaBase](https://github.com/shokai/linda-base)


Install Dependencies
--------------------

Install Rubygems

    % gem install bundler foreman
    % bundle install


Setup Arduino
-------------

Install Arduino Firmata v2.2

    Arduino IDE -> [File] -> [Examples] -> [Firmata] -> [StandardFirmata]

relay -> digital pin 12


Run
---

set ENV var "LINDA_BASE", "LINDA_SPACE" and "ARDUINO"

    % export ARDUINO=/dev/tty.usb-device-name
    % export LINDA_BASE=http://linda.example.com
    % export LINDA_SPACE=test
    % bundle exec ruby linda-delta-lamp.rb


oneline

    % LINDA_BASE=http://linda.example.com LINDA_SPACE=test  bundle exec ruby linda-delta-lamp.rb


Install as Service
------------------

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app linda-delta-lamp -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/linda-delta-lamp-main-1.plist


for upstart (Ubuntu)

    % sudo foreman export upstart /etc/init/ --app linda-delta-lamp -d `pwd` -u `whoami`
    % sudo service linda-delta-lamp start

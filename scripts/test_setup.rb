require './scripts/setup.rb'

FastlaneIT::Tunes::Login.new.perform
FastlaneIT::Tunes::FindApp.new.perform

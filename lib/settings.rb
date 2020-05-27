# encoding: utf-8
class Settings < Settingslogic
  source Padrino.root('config/application.yml')
  namespace "#{Padrino.env}"
end

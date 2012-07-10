Synergy 1C 7.7 Connector
===================

Расширение добавляет поддержку импорта XML файлов с товарами и группами товаров от 1C 7.7.


Установка
==================

Gemfile:  
`gem 'synergy_1c7_connector', :git => 'git://github.com/secoint/synergy_1c7_connector.git'`

    bundle install
    rake synergy_1c7_connector:install:migrations
    rake db:migrate


Использование
==================

Импорт файлов происходит в разделе: Админ-Конфигурация-Коннектор с 1С 7.7. 

Для того, чтобы получить модуль-обработку для 1С 7.7, пишите на synergy@secoint.ru

Copyright (c) 2011 Pavel Belyakov, Service & Consulting (http://secoint.ru)

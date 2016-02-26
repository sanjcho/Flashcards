[![Build Status](https://travis-ci.org/sanjcho/Flashcards.svg?branch=master)](https://travis-ci.org/sanjcho/Flashcards)
[![Code Climate](https://codeclimate.com/github/sanjcho/Flashcards/badges/gpa.svg)](https://codeclimate.com/github/sanjcho/Flashcards)
[![Test Coverage](https://codeclimate.com/github/sanjcho/Flashcards/badges/coverage.svg)](https://codeclimate.com/github/sanjcho/Flashcards/coverage)
# Флешкарточкер

### Цель создания
----
Данный тестовый проект был создан в рамках курса mkdev.me с целью получения практических навыков и знаний в области разработки приложений на RoR.

### Что оно делает?
----
Данное приложение представляет из себя менеджер флеш-карточек. Флеш-карточка это лист бумаги, на которой с двух сторон написан текст: на родном языке с одной стороны, и перевод - с другой. Такие карточки очень популярны для изучения языков. Чаще всего подобные карточки используются при помощи системы интервальных повторений. Это означает, что каждая карточка повторяется через увеличивающиеся интервалы времени. Эффективность подобного метода доказана
StackEdit stores your documents in your browser, which means all your documents are automatically saved locally and are accessible 

Пользователь имеет возможность зарегистрироваться, создавать, редактировать и удалять колоды карт и карты в них. Каждая вновь созданная карта сразу же появляется в тренировщике. Интервалы повторений меняются в соответствии с алгоритмом [SuperMemo2](https://www.supermemo.com/english/ol/sm2.htm). К каждой карточке можно подгрузить картинку-пример, для визуализации и упрощения запоминания.

### Использование 
----
Работающая версия доступна на [heroku](https://flashcards-sanjcho.herokuapp.com/)

Если ты хочешь запустить локальную версию, используй команды `rake db:create` и `bundle install`
Также необходимо изучить файл *config/example_aplication.yml*, он содержит переменные окружения, которые необходимо заполнить для успешного запуска приложения. После этого файл необходимо переименовать в application.yml и добавить в .gitignore. Используй ссылки в комментариях, чтобы получить соответствующие ключи.

Для запуска тестов `rspec spec`

### For english speaker
----
This is a project created in education course on mkdev.me. Project include the most popular gems and services. In cards trainer I have implemented a [SuperMemo2](https://www.supermemo.com/english/ol/sm2.htm) algorithm. You can try my project on [heroku](https://flashcards-sanjcho.herokuapp.com/). Thanks for attension!



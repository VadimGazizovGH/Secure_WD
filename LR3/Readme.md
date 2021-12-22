# Лабораторная работа №3
> Цель работы: Поиск и устранение XSS уязвимостей.

## Задание
В папке lab3 находится nodejs уязвимое приложение. Необходимо развернуть его, найти источники XSS и исправить. Модифицированное приложение загрузить в свой репозиторий GitHub.

Для выполнения лабораторной потребуется проделать следующие шаги (если вы их проделали для лабораторной 2, то повторять не нужно):  
1. Установить PostgreSQL сервер любой версии
2. Создать БД ``lib``  
3. Применить к ней скрипты из папки ``db`` (либо создать объекты и вставить данные в таблицы руками). Скрипты выполнять в порядке указанном в имени файла.
3.1 Восстановить данные из файла ``data.sql``
4. Установить ``nodejs`` версии 14.
5. Перейти в папку ``lab2`` и выполнить в ней команду ``npm install``.
6. Запустить сайт через Visual Studio Code или через команду ``npm start``.

Потребовалось установить cookie-parser

![image](https://user-images.githubusercontent.com/96451409/147098404-158db1c1-845b-423e-a82e-40dce17c858c.png)

7. Войти на сайт и увидеть список книг и авторов
8. На странице со списком книг найти
8.1 Reflected XSS в поиске книг

_**&lt;img src=1 href=1 onerror='javascript:alert(1)'&gt;**_

![image](https://user-images.githubusercontent.com/96451409/147099638-a18f6b48-6b3f-4ed9-8cd6-876dd8644c83.png)

8.2 Persisted (Stored) XSS при создании книги и отображении списка книг

_**&lt;html onclick="alert(1)">test</html&gt;**_

Теперь при любом клике на сайте будет выскакивать окно:

![image](https://user-images.githubusercontent.com/96451409/147099748-c26afecd-dbd7-447c-b61c-3278d45dc02f.png)

Команда в исходном коде:

![image](https://user-images.githubusercontent.com/96451409/147099895-7982cb7a-004c-4f8a-a150-5265ca0e9730.png)

8.3 Потенциальную уязвимость через Cookie Injection

_**&lt;img src=1 onerror='javascript:alert(document.cookie)'/&gt;**_

Добавляем в cookie:

![image](https://user-images.githubusercontent.com/96451409/147100009-b05295c8-9ab5-44ec-9d0a-f8f9924cc11f.png)

Результат при обновлении страницы:

![image](https://user-images.githubusercontent.com/96451409/147100034-8b36b488-6bdb-49de-9609-5cf46609c7a2.png)

8.4 Некорректное создание сессионной cookie, которое приводит к захвату сессии (Session hijacking)

![image](https://user-images.githubusercontent.com/96451409/147100090-5716fa73-1688-4dc7-86bb-bd38c6f99d6b.png)

9. Исправление уязвимостей

Для строки поиска книг можно воспользоваться prepared statement, как в ЛР2

![image](https://user-images.githubusercontent.com/96451409/147100222-d577d901-8765-467c-8afd-a32fb972e94a.png)

![image](https://user-images.githubusercontent.com/96451409/147100346-37171796-55c6-4bd4-8770-83a896dd9586.png)

При добавлении книг самый простой способ – просто заменять символы < и >, например:

_**let bname = req.body.bookname.replace('<', '(').replace('>', ')')**_

![image](https://user-images.githubusercontent.com/96451409/147101158-3c66272c-a5f0-41aa-8362-1f89502ad799.png)

Для уязвимостей Cookie установим флаг http-only, а также изменим значение, выводимое браузером в Value с помощью Sha256:

![image](https://user-images.githubusercontent.com/96451409/147101206-1a3d60a5-0763-484c-a619-5cc1cd01c44e.png)

![image](https://user-images.githubusercontent.com/96451409/147101217-faddfd0b-962a-4183-a06a-6debc4f697a6.png)


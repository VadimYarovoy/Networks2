#import "@preview/colorful-boxes:1.2.0": *

= Практические задание

== Задание 1

#colorbox(
  title: "TODO",
  color: "blue",
  radius: 2pt,
  width: auto
)[
  Попробуйте отправить письмо на вашу почту (mail, yandex, gmail, etc) используя команду
  openssl (узнаете в DNS имя почтового сервера, подключаетесь к нему по нужному порту итд)
]
\
Подготавливаем данные для авторизации:

```bash
echo -n 'your_email@gmail.com' | openssl enc -base64
echo -n 'your_password' | openssl enc -base64
```

Авторизуемся и отправляем письмо:
```bash
250 SMTPUTF8
AUTH LOGIN
334 VXNlcm5hbWU6
<mail_base_64>
334 UGFzc3dvcmQ6
<pass_base_64>
235 2.7.0 Accepted
MAIL FROM: <some@gmail.com>
250 2.1.0 OK l25-20020ac24a99000000b005115fc3d7f8sm228983lfp.205 - gsmtp
rcpt to: <another@gmail.com>
250 2.1.5 OK l25-20020ac24a99000000b005115fc3d7f8sm228983lfp.205 - gsmtp
data
354  Go ahead l25-20020ac24a99000000b005115fc3d7f8sm228983lfp.205 - gsmtp
from: some@gmail.com
to: another@gmail.com
subject: Some cool mail
  
This is a long stiry about ...
.
250 2.0.0 OK  1708166862 l25-20020ac24a99000000b005115fc3d7f8sm228983lfp.205 - gsmtp
```

Смотрим через gmail

#figure(
  image("../pics/1.png", width: 100%),
)

Разберем каждую часть.

+ *250 SMTPUTF8*: Это код ответа от сервера, который указывает, что сервер поддерживает расширение SMTPUTF8 для кодировки Unicode.

+ *AUTH LOGIN*: Это команда, которая инициирует процесс аутентификации. Когда вы видите эту команду, сервер ожидает от вас базовые данные для аутентификации.

+ *334 VXNlcm5hbWU6* и *334 UGFzc3dvcmQ6*: Это вызов для ввода имени пользователя (пользовательский адрес электронной почты) и пароля. Данные кодированы в формате Base64. Таким образом, вы должны ввести имя пользователя и пароль в закодированном виде.

+ *235 2.7.0 Accepted*: Это код ответа, который сообщает, что аутентификация прошла успешно, и сервер принимает команды.

+ *MAIL FROM:\<some\@gmail.com>*: Эта команда указывает адрес отправителя.

+ *250 2.1.0 OK l25-20020ac24a99000000b005115fc3d7f8sm228983lfp.205 - gsmtp*: Это подтверждение от сервера о том, что адрес отправителя принят.

+ *RCPT TO: \<another\@gmail.com>*: Эта команда указывает адрес получателя.

+ *250 2.1.5 OK l25-20020ac24a99000000b005115fc3d7f8sm228983lfp.205 - gsmtp*: Это подтверждение от сервера о том, что адрес получателя принят.

+ *DATA*: Эта команда сообщает серверу о начале передачи данных письма.

+ *354 Go ahead l25-20020ac24a99000000b005115fc3d7f8sm228983lfp.205 - gsmtp*: Сервер готов принимать тело письма. Все данные, введенные после этой команды, будут считаться телом письма.

+ Затем идет само письмо с полями, такими как *"from"*, *"to"*, *"subject"* и текстом письма.

+ *.*: Это команда завершает передачу данных письма.

+ *250 2.0.0 OK 1708166862 l25-20020ac24a99000000b005115fc3d7f8sm228983lfp.205 - gsmtp*: Сервер подтверждает успешное получение и обработку письма.

== Задание 2

#colorbox(
  title: "TODO",
  color: "blue",
  radius: 2pt,
  width: auto
)[
  Подключитесь по IMAP/POP3 к своему почтовому ящику, узнайте информацию о нем,
используя команды протоколов
]

=== IMAP

```bash
openssl s_client -connect imap.gmail.com:993 -crlf -quiet                                                                                                                  
Connecting to 173.194.221.108
depth=2 C=US, O=Google Trust Services LLC, CN=GTS Root R1
verify return:1
depth=1 C=US, O=Google Trust Services LLC, CN=GTS CA 1C3
verify return:1
depth=0 CN=imap.gmail.com
verify return:1
* OK Gimap ready for requests from 178.71.185.95 c9mb22601693ltc
a login some@gmail.com "pass"    
* CAPABILITY IMAP4rev1 UNSELECT IDLE NAMESPACE QUOTA ID XLIST CHILDREN X-GM-EXT-1 UIDPLUS COMPRESS=DEFLATE ENABLE MOVE CONDSTORE ESEARCH UTF8=ACCEPT LIST-EXTENDED LIST-STATUS LITERAL- SPECIAL-USE APPENDLIMIT=35651584
a OK some@gmail.com authenticated (Success)
a status INBOX (MESSAGES RECENT UNSEEN)
* STATUS "INBOX" (MESSAGES 17 RECENT 0 UNSEEN 15)
a OK Success
```

Разберем каждую часть.

+ *openssl s_client -connect imap.gmail.com:993 -crlf -quiet*: Эта команда использует OpenSSL для установки защищенного SSL/TLS соединения с почтовым сервером Gmail на порту 993, который является стандартным портом для протокола IMAP.

+ После установки соединения, сервер возвращает сертификаты SSL, которые клиент (в данном случае OpenSSL) проверяет на валидность.

+ *OK Gimap ready for requests from 178.71.185.95 c9mb22601693ltc*: Сервер приветствует клиента и готов принимать запросы. IP-адрес и некоторая информация о клиенте также предоставляются.

+ *a login some\@gmail.com "pass*": Клиент отправляет команду на аутентификацию. В данном случае, имя пользователя (some\@gmail.com) и пароль ("pass") передаются в виде аргументов команды.

+ *CAPABILITY IMAP4rev1 UNSELECT IDLE NAMESPACE QUOTA ID XLIST CHILDREN X-GM-EXT-1 UIDPLUS COMPRESS=DEFLATE ENABLE MOVE CONDSTORE ESEARCH UTF8=ACCEPT LIST-EXTENDED LIST-STATUS LITERAL- SPECIAL-USE APPENDLIMIT=35651584*: Сервер отвечает, предоставляя список поддерживаемых возможностей (CAPABILITY) в рамках протокола IMAP. Это включает различные расширения, такие как IDLE, UIDPLUS, COMPRESS=DEFLATE и другие.

+ *a OK some\@gmail.com authenticated (Success)*: Сервер подтверждает успешную аутентификацию пользователя.

+ *a status INBOX (MESSAGES RECENT UNSEEN)*: Клиент отправляет команду для запроса статуса почтового ящика INBOX. Сервер возвращает информацию о количестве сообщений, недавно полученных и непрочитанных в ящике.

+ *STATUS "INBOX" (MESSAGES 17 RECENT 0 UNSEEN 15)*: Сервер предоставляет статус ящика INBOX с указанием количества сообщений, недавно полученных, и непрочитанных.

+ *a OK Success*: Сервер подтверждает успешное выполнение команды status и возвращает статус "Success".

=== POP 3
```bash
openssl s_client -connect pop.gmail.com:995 -crlf -quiet                                                                                                                            

Connecting to 64.233.163.108
depth=2 C=US, O=Google Trust Services LLC, CN=GTS Root R1
verify return:1
depth=1 C=US, O=Google Trust Services LLC, CN=GTS CA 1C3
verify return:1
depth=0 CN=pop.gmail.com
verify return:1
+OK Gpop ready for requests from 178.71.185.95 w20mb22708066ltc
USER some@gmail.com
+OK send PASS
PASS <pass>
+OK Welcome.
LIST
+OK 276 messages (626188523 bytes)
1 3294
2 3749
3 3907
...
271 15832
272 14670
273 5151
274 5151
275 5975
276 5975
.
STAT    
+OK 276 626188523
RETR 1
+OK message follows
MIME-Version: 1.0
Received: by 10.49.58.100; Fri, 24 Aug 2012 01:22:20 -0700 (PDT)
Date: Fri, 24 Aug 2012 01:22:20 -0700
Message-ID: <CAByGqTDkcAV+QQDdnqUC+U8tZ=n8256=T793BvS0qffc7yoZ9A@mail.gmail.com>
Subject: =?KOI8-R?B?6dPQz8zY2tXK1MUgR21haWwgzsEg08/Uz9fPzSDU?=
        =?KOI8-R?B?xczFxs/OxQ==?=
From: =?KOI8-R?B?68/MzMXL1MnXIEdtYWls?= <mail-noreply@google.com>
To: =?KOI8-R?B?98HEyc0g8dLP18/K?= <some@gmail.com>
Content-Type: multipart/alternative; boundary=e89a8f921a22babddc04c7feac1d
```

Разберем каждую часть.

+ *openssl s_client -connect pop.gmail.com:995 -crlf -quiet*: Эта команда использует OpenSSL для установки защищенного SSL/TLS соединения с почтовым сервером Gmail на порту 995, который является стандартным портом для протокола POP3 с использованием шифрования.

+ После установки соединения, сервер возвращает сертификаты SSL, которые клиент (в данном случае OpenSSL) проверяет на валидность.

+ *+OK Gpop ready for requests from 178.71.185.95 w20mb22708066ltc*: Сервер приветствует клиента и готов принимать запросы. IP-адрес и некоторая информация о клиенте также предоставляются.

+ *USER some\@gmail.com*: Клиент отправляет команду на аутентификацию пользователя, указывая имя пользователя (some\@gmail.com).

+ *+OK send PASS*: Сервер подтверждает получение имени пользователя и ожидает команды для отправки пароля.

+ *PASS <pass>*: Клиент отправляет свой пароль в зашифрованном виде.

+ *+OK Welcome.*: Сервер подтверждает успешную аутентификацию пользователя.

+ *LIST*: Клиент запрашивает список сообщений на сервере.

+ *+OK 276 messages (626188523 bytes)*: Сервер отвечает, сообщая об общем количестве сообщений и их общем размере.

+ *1 3294, 2 3749, ..., 276 5975*: Сервер предоставляет список сообщений с номерами и их размерами.

+ *STAT*: Клиент запрашивает статистику по почтовому ящику.

+ *+OK 276 626188523*: Сервер отвечает, предоставляя информацию о количестве сообщений и их общем размере.

+ *RETR 1*: Клиент запрашивает текст первого сообщения.

+ *+OK message follows*: Сервер подтверждает и готов отправить содержимое сообщения.

+ Затем идет фрагмент текста письма

#pagebreak()
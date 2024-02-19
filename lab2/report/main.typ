#import "template.typ": *

#show: project.with(
  type: "Практическая работа №2",
  subject: "«Сети и телекоммуникации»",
  authors: (
    (name: "Яровой В. Д.", 
    group: "5130904/00104",
    tutor: "Медведев Б. М."),
  ),
  abstract: none
)

#show raw.where(block: true): block.with(
  width: 100%,
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  stroke: black,
  breakable: true
)

#set heading(numbering: "1.1")

#include "typ/questions.typ"
#include "typ/task.typ"

= Вывод

В процессе выполнения команд были установлены защищенные SSL/TLS соединения с серверами Gmail для протоколов IMAP, SMTP и POP3. Затем произведена аутентификация почтового ящика, выполнены запросы о статусе почтового ящика, получен список сообщений, а также извлечено и отображено содержимое одного из писем в формате MIME.
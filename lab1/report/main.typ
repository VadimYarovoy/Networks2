#import "template.typ": *

#show: project.with(
  type: "Практическая работа №1",
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
Были использованы и проанализированы базовые сетевые команды и файлы конфигурации. Настроено безопасное подключение по SSH с использованием ключей, а также рассмотрены меры безопасности и различные настройки для улучшения безопасности подключений. Получены практические навыки работы с основными сетевыми инструментами и сервисами.

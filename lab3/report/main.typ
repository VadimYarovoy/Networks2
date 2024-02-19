#import "template.typ": *

#show: project.with(
  type: "Практическая работа №3",
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


В результате проделанной работы были настроены и развернуты контейнеры с использованием Docker Compose для веб-сервера (Nginx), сервера приложений (PHP-FPM), базы данных (MySQL), и веб-приложения (WordPress). Осуществлены оптимизации настроек для улучшения производительности, безопасности и поддержки SSL. Система готова к использованию, обеспечивая надежное и эффективное развертывание веб-приложения.


#import "@preview/colorful-boxes:1.2.0": *

= Ответы на вопросы


== Вопрос 1
#colorbox(
  title: "TODO",
  color: "blue",
  radius: 2pt,
  width: auto
)[
  Что такое IP адрес, MAC адрес, маска подсети, порт
]

IP-адрес (Internet Protocol address) - это уникальный числовой идентификатор, присвоенный устройству (компьютеру, принтеру, маршрутизатору и т.д.) в сети, чтобы обеспечивать его идентификацию и обмен данными в сети.

MAC-адрес (Media Access Control address) - это уникальный идентификатор, присвоенный сетевому интерфейсу для обеспечения его уникальности в рамках локальной сети. Он используется на более низком уровне сетевого стека, чем IP-адрес, и обычно привязан к аппаратному оборудованию.

Маска подсети - это числовое значение, определяющее, какая часть IP-адреса относится к сети, а какая к устройству в этой сети. Она помогает разделять IP-адрес на сетевую и хост-части.

Порт - это логический номер, используемый для идентификации конкретного процесса, который обменивается данными через сеть. В контексте TCP/IP порты разделяются на три диапазона: известные порты (0-1023), зарегистрированные порты (1024-49151) и динамические порты (49152-65535).
== Вопрос 2
#colorbox(
  title: "TODO",
  color: "blue",
  radius: 2pt,
  width: auto
)[
  Чем хорош и чем плох Telnet
]

Telnet - это протокол удаленного управления, который позволяет пользователю управлять удаленным компьютером через сеть. Однако Telnet передает данные в открытом виде, не обеспечивая шифрование, что делает его небезопасным для передачи чувствительной информации, такой как пароли. Лучше использовать безопасные альтернативы, такие как SSH.

== Вопрос 3
#colorbox(
  title: "TODO",
  color: "blue",
  radius: 2pt,
  width: auto
)[
  Как можно улучшить безопасность подключения при использовании SSH
]


Использование ключей вместо паролей для аутентификации.
Ограничение доступа через настройку файрвола и конфигурации SSH.
Изменение порта SSH для усложнения атак.
Отключение доступа к системе по умолчанию (парольного доступа) и использование только ключей.
Регулярное обновление SSH и других компонентов системы.

== Вопрос 4
#colorbox(
  title: "TODO",
  color: "blue",
  radius: 2pt,
  width: auto
)[
Когда стоит использовать авторизацию по паролю, а когда по ключам, при подключении по SSH
]

Авторизация по паролю стоит использовать, когда ключи недоступны или неудобны для использования.
Авторизация по ключам является более безопасным вариантом, так как предотвращает атаки на подбор паролей и обеспечивает сильную аутентификацию. Рекомендуется использовать ключи в более критичных сценариях.

#pagebreak()
== Requirements:
- `brew install ffmpeg`
- `brew install ffmpegthumbnailer`
- `brew install redis`

== Setup:
Ensuite, en meme temps que le serveur web, lancer redis et sidekiq.
Sidekiq utilise une queue "carrierwave", donc le lancer en ligne de commande, directement dans le dossier du projet rails, avec la commande `sidekiq -q carrierwave`.

> Par défaut, sidekiq utilise redis sur les ports par défauts, mais j'imagine qui si quelque chose est mal conf a ce niveau, il vous crachera au visage.

Ensuite, vous pouvez créer une nouvelle vidéo, et visualiser les tasks sidekiq à l'url  `http://localhost:xxxx/sidekiq/queues/carrierwave`.

Coté frontend, j'ai commencé à organiser les bouts de coffee sous formes de modules indépendants. Il y a déja le module Core.Media.Thumbnail ( *Note: le namespace est changeable* ) qui rajoute une preview a la youporn au hover (`app/assets/javascripts/42/media/thumbnail.js.coffee`).

Vu que le traitement de la video peut prendre du temps - surtout avec les videos HD de Trentin -, je pensais qu'on pouvait aussi rajouter soit **une notification websocket** (#audace) / **soit un email**, a la fin du traitement, pour prévenir que la video est en ligne...

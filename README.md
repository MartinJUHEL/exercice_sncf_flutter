# exercice_sncf

Pour cet exercice, j'ai choisi d'utiliser la librairie Riverpod pour créer l'architecture MVVM de l'application.
J'utilise également Riverpod pour injecter mes services dans mes viewsModel.
J'ai crée un PageView pour afficher la méteo par jour.

Pour le stockage du login j'utilise la librairie sharePreference.
J'ai mis aussi un refreshIndicator pour forcer la récupération des données.

J'ai ajouté la possibilité de récupérer la méteo sur la posisition de l'utilisateur. Le switch button dans le Drawer permet de passer de la localisation de l'utilisateur à celle de Paris.

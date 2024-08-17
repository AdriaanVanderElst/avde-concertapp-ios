# Concert planning app

Deze iOS applicatie is een tool voor leden van een groep om geplande en afgelopen concerten te raadplegen. De gegevens voor deze concerten worden opgehaald van een beveiligde [REST API](https://concertapi-service-app.onrender.com). De gebruiker kan na inloggen een overzicht van concerten raadplegen, de details voor een concert raadplegen en eventuele opmerkingen aanpassen of toevoegen, die worden bijgehouden in de API.

## Logingegevens
- email: admin@concertapp.com
- password: Admin!capp01

## Opmerkingen
- De API draait via een gratis service, en sluit automatisch af na een periode van inactiviteit. Na opstarten van de app kan de eerste GET request naar de api (om concerten op te halen) relatief lang duren.

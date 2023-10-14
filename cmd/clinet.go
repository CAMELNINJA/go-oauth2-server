package cmd

import "github.com/RichardKnop/go-oauth2-server/oauth"

func NewClient(clientID, clientSecret, redirectURI, configBackend string) error {
	cnf, db, err := initConfigDB(true, false, configBackend)
	if err != nil {
		return err
	}
	defer db.Close()

	// start the services
	OauthService := oauth.NewService(cnf, db)
	defer OauthService.Close()

	_, err = OauthService.CreateClient(clientID, clientSecret, redirectURI)
	return err
}

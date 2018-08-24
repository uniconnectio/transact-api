# UniConnect Transact™ API
This repo contains OpenAPI Specification (fka Swagger) files for UniConnect 
Transact™ Open Banking API

## Customer Journeys
UniConnect Transact™ Open Banking API can be used to implement some very 
exciting customer jouneys, across a range of channels such as Mobile Apps, 
Smart assistants such as Amazon Alexa, Microsoft Cortana and Google Assistant,
chatbot applications, and countless others. In the sections below, we have 
shown some examples of customer journeys that can be implemented using 
UniConnect Transact™ APIs.  

### Accounts Inquiry

1. Start with calling `POST /security/authentication/access-token`, submitting a 
customer's username and password (we will soon support other OAuth2 grant types). 
This operation returns an access token, which is used to get customer's data 
through other APIs. 
2. After receiving an access token, call `GET /customermgmt/welcome/profile` and 
`GET /customermgmt/welcome/messages` to fetch customer's basic profile and list 
of welcome messages. 
3. Next, call `GET /accountmgmt/retail/accounts` to get a list of all accounts 
(with balances) that belong to the customer. 
4. To get more detailed data for an account, including other balance types, you 
can call `GET /accountmgmt/retail/accounts/{id}`
5. To get a history of recent transactions for an account, call 
`GET /accountmgmt/retail/accounts/{id}/transactions` 
6. Lastly, calling operation `GET /customermgmt/profile/profile` will return
customer's full profile, which includes biographics, demographics, contacts, and 
other personal details. 



Drush command policies  have been implemented to prevent the execution of  certain drush commands: 'core:sync', 
'sql:sync', and 'sql:drop' in production or other environment instances. 

To apply these policies, two actions must be taken:
- In the definition of the alias for the environment where you want these policies to be applied you have to add the parameter: "protected-instance: true"
- On the server of the environment, copy the 'drush/Commands/drush.yml.dist' to the user's .drush folder of the user used for SSH connections to the server.
# Behavior Driven Development on natural language with Behat

[Behavior Driven Development](https://en.wikipedia.org/wiki/Behavior-driven_development) is supported on a natural language thanks to [Behat](https://docs.behat.org/en/latest/).
The boilerplate is delivered with Behat preconfigured, so you just need to start writing your tests. Some example tests
are also provided. Additionally to Behat, some libraries are included improving the Drupal support, adding several Behat
testing steps for the most common use cases such as logging as a user with a particular role, creating testing content, finding
expressions within content regions, etc.

Here are the bundled libraries:

- [drupal-extension](https://www.drupal.org/project/drupalextension)
- [nuvoleweb/drupal-behat](https://github.com/nuvoleweb/drupal-behat)
- [metadrop/behat-contexts](https://github.com/metadrop/behat-contexts)

#### Run Behat tests

If you want to execute every Behat tests just run:


```
make behat
```

Or if oyu need to pass parameters to Behat executable run it directly inside the container:

```
docker-compose exec php behat
```


@TODO: Explain configuration (whay, why and how)

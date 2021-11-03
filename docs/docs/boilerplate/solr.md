# Solr

Although the Solr container is not enabled by default, some commands to manage the Solr server are provided.

  - Core configuration sync: recreates the Solr core using the core configuration files from project.

    ```
    make solr-sync:
    ```

@TODO: solr-sync calls `./scripts/solr-sync.sh` which is not present in boilerplate, missing from scripthor? removed from boilerplate?

 -  Rebuild Solr server: sometimes Solr server needs to be completely recreated. This means completely delete and recreate the container and associated a data, a run the core configuration sync task to recreate the cores as well. To do so, run the following command:

    ```
    make solr-rebuild
    ```

@TODO: solr-rebuild calls solr-sync, and solr.sync has an issue

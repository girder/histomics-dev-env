## HistomicsUI development environment

### Note for Mac users

On Macs with ARM CPUs, you must set the following environment variable prior to building:

    export DOCKER_DEFAULT_PLATFORM=linux/amd64

### Initial setup

The first time you use this, run:

```bash
./init.sh
```

That command will clone all relevant repos and build the docker-compose environment.

### Development

These repositories' source files will all be bind-mounted into the appropriate
place in the container at runtime. Open your IDE in the repository subdirectories when
working on them. To spin up the dev environment, run:

```bash
docker-compose up
```

The server will be accessible from your host at `0.0.0.0:8080`.

#### Backend development

Whenever you change a Python file within one of the plugins cloned into the subdirectories, it will
auto-reload the server.

Unfortunately, one limitation is that girder-worker (celery) does not auto-reload on code changes.
The container will need to be manually restarted in order to reflect changes in celery tasks or
girder worker configuration.

#### Frontend development

For front-end development, you can `cd` to the relevant `web_client` directory within the
subdirectories on your host and run `npm run watch`. Changes will trigger a rebuild, then you will
need to manually refresh your browser to see the changes.

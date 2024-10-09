# HistomicsUI development environment

### Initial setup

The first time you use this, run:

```bash
./init.sh
```

That command will clone all relevant repos and build the docker-compose environment.

## Development

These repositories' source files will all be bind-mounted into the appropriate
place in the container at runtime. Open your IDE in the repository subdirectories when
working on them. To spin up the dev environment, run:

```bash
docker-compose up
```

The server will be accessible from your host at `0.0.0.0:8080`.

### Backend development

Whenever you change a Python file within one of the plugins cloned into the subdirectories, it will
auto-reload the server.

Unfortunately, one limitation is that girder-worker (celery) does not auto-reload on code changes.
The container will need to be manually restarted in order to reflect changes in celery tasks or
girder worker configuration.

### Frontend development

For front-end development, you can `cd` to the relevant `web_client` directory within the
subdirectories on your host and run `npm run watch`. Changes will trigger a rebuild, then you will
need to manually refresh your browser to see the changes.


#### Running the tests

To run browser tests, first ensure your docker-compose is running, then run:

```bash
docker-compose run -p 9323:9323 --rm histomicsui /bin/bash -c 'cd /opt/HistomicsUI/histomicsui/web_client && npm run test'
```

### Recording new playwright tests

#### Initial setup

For recording front-end tests with interactive playwright, it's easiest to run playwright natively
on your host. Install the VSCode plugin for Playwright, and run the following command once:

```bash
cd HistomicsUI/histomicsui/web_client && npx playwright install chromium
```

In your VSCode `settings.json`, add the following configuration:

```json
"playwright.env": {
    "GIRDER_CLIENT_TESTING_KEEP_SERVER_ALIVE": "true",
    "HISTOMICS_PLAYWRIGHT_DEV": "true",
},
```

This will keep girder running after the test runs, allowing you to record at your cursor.

#### Recording

In the `Testing` view in VSCode, find the test you want to append to, select it, and click "Run Test".
Open the test file in the editor, place the cursor at the relevant position, and click "Record at cursor".
Then interact with the Chromium window to record the test script.

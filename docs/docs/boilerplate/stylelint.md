@TODO: complete and clarify section

### Stylelint CSS

[Stylelint](https://stylelint.io/) is a modern linter that helps you avoid errors and enforce conventions in your styles.


#### Installation

* Install stylelint as dependency on your custom theme folder:

      npm i stylelint --save-dev

* Install stylelint scss plugin, if you use sass

      npm i stylelint-scss --save-dev

* Install stylelint mix plugin in order to use it with webpack.

      npm i laravel-mix-stylelint --save-dev

* Create .stylelintrc.yml file with your [stylelint rules](https://stylelint.io/developer-guide/rules). For a reference, these are [Metadrop's](https://gitlab.com/-/snippets/2067128).

* Run stylelint checker

      npx stylelint 'src/**/*.scss'

##### Run from npm

You can run stylelint from npm

Add to the package.json the following script:

```json
  "scripts": {
    "css:lint": "npx stylelint 'src/**/*.scss'"
  }
```

Then execute the following command

```bash
npm run css:lint
```

##### Run using Laravel Mix

Radix uses Laravel Mix, a wrapper around Webpack for common build processes.
You can add Stylelint to your `webpack.mix.js` on your Radix subtheme.

Install Webpack Stylelint plugin:

```bash
npm i stylelint-webpack-plugin --save-dev
```

Then add the following lines to the webpack file.

```js
const stylelint = require('laravel-mix-stylelint');
mix
  .stylelint({
    configFile: path.join(__dirname, '.stylelintrc.yml'),
    context: './src',
    failOnError: false,
    files: ['**/*.scss']
  })
```



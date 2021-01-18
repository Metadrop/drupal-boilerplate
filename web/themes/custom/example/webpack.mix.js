/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your application. See https://github.com/JeffreyWay/laravel-mix.
 |
 */
const proxy = 'http://example.docker.localhost:8000/';
const mix = require('laravel-mix');
const stylelint = require( 'laravel-mix-stylelint' );

/*
 |--------------------------------------------------------------------------
 | Configuration
 |--------------------------------------------------------------------------
 */
mix
    .webpackConfig({
        externals: {
            jquery: 'jQuery'
        }
    })
    .setPublicPath('assets')
    .disableNotifications()
    .options({
        processCssUrls: false
    });

/*
 |--------------------------------------------------------------------------
 | Browsersync
 |--------------------------------------------------------------------------
 */
mix.browserSync({
    proxy: proxy,
    files: ['assets/js/**/*.js', 'assets/css/**/*.css'],
    stream: true,
});

/*
 |--------------------------------------------------------------------------
 | SASS
 |--------------------------------------------------------------------------
 */

const sassConfig = {
    sassOptions: {
        includePaths : ['../']
    }
}

mix
    .stylelint({
        configFile: path.join(__dirname, '.stylelintrc.yml'),
        context: './src',
        failOnError: false,
        files: ['**/*.scss'],
        fix: true,
    })
    .sass('src/sass/example.style.scss', 'css', sassConfig)
    .sass('src/sass/ckeditor.style.scss', 'css', sassConfig);

/*
 |--------------------------------------------------------------------------
 | JS/TS
 |--------------------------------------------------------------------------
 */
mix.js('src/js/example.script.js', 'js')
    .js('src/js/SmoothScroll.js', 'js')
    .js('src/js/jquery.sticky-kit.min.js', 'js')
    .ts('src/js/typescript_test.ts', 'js')

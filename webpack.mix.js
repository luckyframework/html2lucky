// Docs: https://github.com/JeffreyWay/laravel-mix/tree/master/docs#readme

let mix = require("laravel-mix");
let plugins = [];

// Customize the notifier to be less noisy
let WebpackNotifierPlugin = require("webpack-notifier");
let webpackNotifier = new WebpackNotifierPlugin({
  alwaysNotify: false,
  skipFirstNotification: true,
});
plugins.push(webpackNotifier);

if (mix.inProduction()) {
  let CompressionWepackPlugin = require("compression-webpack-plugin");
  let gzipCompression = new CompressionWepackPlugin({
    compressionOptions: { level: 9 },
    test: /\.js$|\.css$|\.html$|\.svg$/,
  });
  plugins.push(gzipCompression);
}

mix
  .js("src/js/app.js", "public/js")
  .sass("src/css/app.scss", "public/css")
  .options({
    postCss: [require("lost")],
    imgLoaderOptions: { enabled: false },
    clearConsole: false,
  })
  .setPublicPath("public")
  .version(["public/assets"])
  // Reduce noise in Webpack output
  .webpackConfig({
    stats: "errors-only",
    plugins: plugins,
  })
  // Disable default Mix notifications because we're using our own notifier
  .disableNotifications();

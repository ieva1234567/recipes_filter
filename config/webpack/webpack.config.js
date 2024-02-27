const { webpackConfig, inliningCss } = require('shakapacker')
const Dotenv = require('dotenv-webpack');

const isDevelopment = process.env.NODE_ENV !== 'production';
if (isDevelopment && inliningCss) {
  const ReactRefreshWebpackPlugin = require('@pmmmwh/react-refresh-webpack-plugin');
  webpackConfig.plugins.push(
    new ReactRefreshWebpackPlugin({
      overlay: {
        sockPort: webpackConfig.devServer.port,
      },
    })
  );
}
// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.

if (process.env.NODE_ENV === 'production') {
   webpackConfig.devtool = false;
}

webpackConfig.plugins.push(new Dotenv());
module.exports = webpackConfig;

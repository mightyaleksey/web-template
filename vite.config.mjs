import { defineConfig } from 'vite'
import babel from 'vite-plugin-babel'

const babelConfig = {
  babelrc: false,
  configFile: false,
  plugins: ['babel-plugin-syntax-hermes-parser'],
  presets: ['@babel/preset-flow']
}

/**
 * mode - 'development', 'production'
 * command - 'build', 'serve'
 * isSsrBuild - boolean
 * isPreview - boolean
 */
export default defineConfig(props => {
  switch (props.command) {
    case 'build':
      return {
        build: {
          minify: true,
          target: 'es2020',
          modulePreload: { polyfill: false },
          assetsInlineLimit: 800
        },
        esbuild: true,
        plugins: [babel({ babelConfig })]
      }

    default:
      return {
        plugins: [babel({ babelConfig })]
      }
  }
})

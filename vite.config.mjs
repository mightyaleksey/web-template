import { flowPlugin, esbuildFlowPlugin } from '@bunchtogether/vite-plugin-flow'

export default {
  optimizeDeps: {
    esbuildOptions: {
      // plugin removes only types, however, enums are left intact
      // (additional transformation is required).
      plugins: [esbuildFlowPlugin()]
    }
  },
  plugins: [flowPlugin()]
}
